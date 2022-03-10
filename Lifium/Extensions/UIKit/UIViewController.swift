//
//  UIViewController.swift
//  MPL
//
//  Created by Hakikat Singh on 15/06/21.
//

import UIKit

enum PresentType {
    case push
    case present
}

extension UIViewController {
    
    class func instantiate<T: UIViewController>(viewControllerOfType type: T.Type, storyboardName: String, bundle: Bundle? = nil) -> T {
        
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: "\(type)") as! T
    }
    
    class func instantiate<T: UIViewController>(viewControllerOfType type: T.Type, nibName: String? = nil, bundle: Bundle? = nil) -> T {
        
        if let name = nibName {
            return T(nibName: name, bundle: bundle)
        } else {
            return T(nibName: "\(type)", bundle: bundle)
        }
        
    }
    
    
    func isPresentedModally() -> Bool {
        return self.presentingViewController?.presentedViewController == self
    }
    
    func findContentViewControllerRecursively() -> UIViewController {
        var childViewController: UIViewController?
        if (self is UITabBarController) {
            childViewController = (self as? UITabBarController)?.selectedViewController
        }
        else if (self is UINavigationController) {
            childViewController = (self as? UINavigationController)?.topViewController
        }
        else if (self is UISplitViewController) {
            childViewController = (self as? UISplitViewController)?.viewControllers.last
        }
        else if (self.presentedViewController != nil) {
            childViewController = self.presentedViewController
        }
        let shouldContinueSearch: Bool = (childViewController != nil) && !((childViewController?.isKind(of: UIAlertController.self))!)
        return shouldContinueSearch ? childViewController!.findContentViewControllerRecursively() : self
    }
    
    
    
    func customRemoveFromParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func customRemoveAllChildViewControllers() {
        for control: UIViewController in self.children {
            control.customRemoveFromParentViewController()
        }
    }
    
    //----------------------------------------------------------------------
    // MARK:- Basic Alert View
    //----------------------------------------------------------------------
    
    
    func showAlert(withTitle title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    
    //----------------------------------------------------------------------
    // MARK:- Navigate to ViewController
    //----------------------------------------------------------------------
    
    func startVC(vc: UIViewController, with presentType: PresentType = .push) {
        if presentType == .push {
            self.navigationController?.pushViewController(vc, animated: true)
        } else if presentType == .present {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func popOrDismissViewController(_ animated: Bool) {
        if self.isPresentedModally() {
            self.dismiss(animated: animated, completion:nil)
        } else if (self.navigationController != nil) {
            _ = self.navigationController?.popViewController(animated: animated)
        }
    }
    
    
    func isVisible(view: UIView) -> Bool {
        if view.isHidden || view.superview == nil {
            return false
        }
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController,
           let rootView = rootViewController.view {
            
            let viewFrame = view.convert(view.bounds, to: rootView)
            
            let topSafeArea: CGFloat
            let bottomSafeArea: CGFloat
            
            if #available(iOS 11.0, *) {
                topSafeArea = rootView.safeAreaInsets.top
                bottomSafeArea = rootView.safeAreaInsets.bottom
            } else {
                topSafeArea = rootViewController.topLayoutGuide.length
                bottomSafeArea = rootViewController.bottomLayoutGuide.length
            }
            
            return viewFrame.minX >= 0 &&
                viewFrame.maxX <= rootView.bounds.width &&
                viewFrame.minY >= topSafeArea &&
                viewFrame.maxY <= rootView.bounds.height - bottomSafeArea
        }
        
        return false
    }
}


extension Array where Iterator.Element == UIViewController {

    var previous: UIViewController? {
        if self.count > 1 {
            return self[self.count - 2]
        }
        return nil
    }

}
