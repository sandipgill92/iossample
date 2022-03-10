//
//  FeedBackManager.swift
//  Lifium
//
//  Created by Sandip Gill on 08/03/22.
//

import Foundation
import MessageUI

struct Feedback {
    let recipients : String
    let subject: String
}

class FeedbackManager: NSObject, MFMailComposeViewControllerDelegate {
    
    private var feedback: Feedback
    
    private var completion: ((Result<MFMailComposeResult,Error>)->Void)?
    
    override init() {
        fatalError("Use FeedbackManager(feedback:)")
    }
    
    init?(feedback: Feedback) {
        guard MFMailComposeViewController.canSendMail() else {
            return nil
        }
        
        self.feedback = feedback
    }
    
    func send(on viewController: UIViewController, completion:(@escaping(Result<MFMailComposeResult,Error>)->Void)) {
        
        let mailVC = MFMailComposeViewController()
        self.completion = completion
        
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([feedback.recipients])
        mailVC.setSubject("Feedback: \(feedback.subject)")
        
        viewController.present(mailVC, animated:true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            completion?(.failure(error))
        } else {
            completion?(.success(result))
        }
    }
}
