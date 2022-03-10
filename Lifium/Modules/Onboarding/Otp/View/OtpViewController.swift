//
//  OtpViewController.swift
//  Lifium
//
//  Created by Hakikat Singh on 27/02/22.
//

import UIKit
import SVProgressHUD

class OtpViewController: BaseViewController {
    
    class func control(_ phoneNumber : String)-> OtpViewController{
        let control = self.control as! OtpViewController
        control.phoneNumber = phoneNumber
        return control
    }
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var firstOtpField: CustomTextField!
    @IBOutlet weak var secondOtpField: CustomTextField!
    @IBOutlet weak var thirdOtpField: CustomTextField!
    @IBOutlet weak var fourthOtpField: CustomTextField!
    
    var phoneNumber: String?
    var viewModel = OtpViewModel()
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    //MARK:- FUNCTIONS
    func setupViews(){
        self.phoneNumberLabel.text = self.phoneNumber
        let textFields = [firstOtpField, secondOtpField, thirdOtpField, fourthOtpField]
        for i in 0...textFields.count-1{
            textFields[i]?.textField.textAlignment = .center
            textFields[i]?.textField.delegate = self
        }
    }
    
    func requestOTPVerify(){
        var model = RequestVerifyOTP()
        model.phoneNumber = self.phoneNumber?.chopPrefix(3)
        model.otp = firstOtpField.textField.text!+secondOtpField.textField.text!+thirdOtpField.textField.text!+fourthOtpField.textField.text!
        self.viewModel.verifyOTP(model) { response, error in
            DispatchQueue.main.async {
                if response != nil && error == nil{
                    if response?.profileData?.isProfileCompleted == true{
                        UserStore.shared.isLogin = true
                        ActionHome.execute()
                    }else{
                        self.navigationController?.pushViewController(CreateProfileViewController.control, animated: true)
                    }
                }else{
                    SVProgressHUD.showError(withStatus: error)
                }
            }
        }
    }
}
//MARK: - TextField Handling
extension OtpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        
        let textFields = [firstOtpField, secondOtpField, thirdOtpField, fourthOtpField]
        if string == "" {
            for i in 0...textFields.count-1{
                
                if textField == textFields[0]?.textField {
                    return true
                }
                if textField == textFields[i]?.textField {
                    textField.resignFirstResponder()
                    textFields[i-1]?.textField.becomeFirstResponder()
                    textFields[i]?.textField.text = string
                }
            }
            return false
        }
        if textField.text?.count ?? 0 > 0 {
            for i in 0...textFields.count-1{
                
                if i == 3 {
                    textField.resignFirstResponder()
                    return false
                } else if textField == textFields[i]?.textField {
                    
                    textField.resignFirstResponder()
                    textFields[i+1]?.textField.becomeFirstResponder()
                    textFields[i+1]?.textField.text = string
                    if i+1 == 3 {
                        self.otpApiMethod(string)
                    }
                }
            }
        }
        return true
    }
    
    func otpApiMethod(_ otp: String){
        self.fourthOtpField.textField.resignFirstResponder()
        if firstOtpField.textField.text?.count ?? 0 > 0 && secondOtpField.textField.text?.count ?? 0 > 0 && thirdOtpField.textField.text?.count ?? 0 > 0 && fourthOtpField.textField.text?.count ?? 0 > 0 {
            self.requestOTPVerify()
        }
    }
    
}
