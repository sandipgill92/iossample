//
//  CreateProfileViewController.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import UIKit
import SVProgressHUD

class CreateProfileViewController: BaseViewController {

    @IBOutlet weak var firstNameField: CustomTextField!
    @IBOutlet weak var lastNameField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var continueButton: ThemeButton!
    
    var viewModel : CreateProfileViewModel!
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //MARK:- FUNCTIONS
    func setupView(){
        self.customNavigationView.showOnlyTitle(isLeftTitle: true, isCenterTitle: false, title: .createProfile)
        
        let textfields = [firstNameField, lastNameField, emailTextField]
        let headings = [CreateProfileString.shared.firstNameHeading, CreateProfileString.shared.lastNameHeading,CreateProfileString.shared.emailHeading]
        for i in 0...textfields.count-1{
            textfields[i]?.textField.delegate = self
            textfields[i]?.configureTextField(text: headings[i], placeholder: headings[i])
        }
    }
    
    func validate(_ completion : @escaping(_ : Bool)->Void){
        if firstNameField.textField.isEmpty{
            firstNameField.textField.leadingAssistiveLabel.text = CreateProfileString.shared.firstNameError
            completion(false)
        }else if lastNameField.textField.isEmpty{
            lastNameField.textField.leadingAssistiveLabel.text = CreateProfileString.shared.lastNameError
            completion(false)
        }else if emailTextField.textField.isEmpty{
            emailTextField.textField.leadingAssistiveLabel.text = CreateProfileString.shared.emailError
            completion(false)
        }else if !emailTextField.textField.isValidEmail{
            emailTextField.textField.leadingAssistiveLabel.text = CreateProfileString.shared.emailValidError
            completion(false)
        }
        else{
            completion(true)
        }
    }
    
    func createProfile(){
        var model = RequestCreateProfile()
        model.firstName = firstNameField.textField.text
        model.lastName = lastNameField.textField.text
        model.email = emailTextField.textField.text
        self.viewModel = CreateProfileViewModel()
        self.viewModel.createProfile(model) { isSuccess, error  in
            DispatchQueue.main.async {
                if isSuccess && error == nil{
                    UserStore.shared.isLogin = true
                    ActionHome.execute()
                }else{
                    SVProgressHUD.showError(withStatus: error)
                }
            }
        }
    }
    
    //MARK: - Continue Button Action
    @IBAction func continueButtonAction(_ sender: Any) {
        self.validate { isValid in
            if isValid{
                self.createProfile()
            }
        }
    }

}


extension CreateProfileViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        firstNameField.textField.leadingAssistiveLabel.text = ""
        lastNameField.textField.leadingAssistiveLabel.text = ""
        emailTextField.textField.leadingAssistiveLabel.text = ""
    }
}
