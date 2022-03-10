//
//  LoginViewController.swift
//  Lifium
//
//  Created by Hakikat Singh on 23/02/22.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var loginButton: ThemeButton!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    
    let viewModel = LoginViewModel()
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
    }
    
    //MARK:- SETUP UI
    private func setViews(){
        self.phoneNumberTextField.configureTextField(text: OnboardingStrings.shared.mobileTextFieldPlaceHolder, placeholder: OnboardingStrings.shared.mobileTextFieldPlaceHolder)
        phoneNumberTextField.textField.delegate = self
    }
    
    //MARK:- FUNCTIONS
    func validateTextfield(_ completion : @escaping(_ : Bool)-> Void){
        if phoneNumberTextField.textField.text?.count ?? 0 < OnboardingStrings.shared.phoneNumberLength{
            phoneNumberTextField.textField.leadingAssistiveLabel.textColor = R.color.theme()
            phoneNumberTextField.textField.leadingAssistiveLabel.text = OnboardingStrings.shared.phoneNumberError
            completion(false)
        }else{
            completion(true)
        }
    }
    
    //MARK:- REQUEST LOGIN
    func requestLogin(){
        var model = RequestLoginModel()
        model.phoneNumber = phoneNumberTextField.textField.text?.chopPrefix(3)
        self.viewModel.login(model) { response, error in
            DispatchQueue.main.async {
                if response && error == nil{
                    self.navigationController?.pushViewController(OtpViewController.control(self.phoneNumberTextField.textField.text ?? ""), animated: true)
                }else{
                    self.phoneNumberTextField.textField.leadingAssistiveLabel.text = error
                }
            }
        }
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func loginButton(_ sender: ThemeButton) {
        self.validateTextfield { isValid in
            if isValid{
                DispatchQueue.main.async {
                    self.requestLogin()
                }
            }
        }
    }

}


extension LoginViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneNumberTextField.textField.text = OnboardingStrings.shared.indianCountryCode
        phoneNumberTextField.textField.leadingAssistiveLabel.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = OnboardingStrings.shared.phoneNumberLength
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
}
