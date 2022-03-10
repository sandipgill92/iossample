//
//  ImagePickerManager.swift
//  Lifium
//
//  Created by Sandip Gill on 10/03/22.
//

import UIKit
import Photos
import AVFoundation

let NEVER_HAVE_CAMERA_ACCESS = "You don't have camera access now. Click on Settings to give camera access"
let NEVER_HAVE_LIBRARY_ACEESS = "You don't have photo library access now. Click on Settings to give photo library access"

protocol ImagePickerManagerDelegate: class {
  func selectedImage(image: UIImage)
  func cancelToSelectImage()
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let shared = ImagePickerManager()
    weak var delegate: ImagePickerManagerDelegate?
    
    override init() {}
    
    func openActionSheetForImages(onVC: UIViewController ,completion: @escaping (_ success: Bool) -> Void) {
    
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "Photo library", style: .default , handler:{ (UIAlertAction)in
        completion(true)
        self.checkLibraryPermission(completion: { (status) in
          if status {
             DispatchQueue.main.async {
            self.getImage(viewController: onVC, sourceType: "library")
            }
          }
        })
      }))
      
      alert.addAction(UIAlertAction(title: "Take photo", style: .default , handler:{ (UIAlertAction)in
        completion(true)
        self.checkCameraPermission(completion: { (status) in
          if status {
            DispatchQueue.main.async {
               self.getImage(viewController: onVC, sourceType: "camera")
            }
          }
        })
      }))
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        completion(false)
      }))
    
      onVC.present(alert, animated: true, completion: {
      })
    }
    
    private func getImage(viewController: UIViewController, sourceType: String) {
      
      delegate = viewController as? ImagePickerManagerDelegate
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      switch sourceType {
      case "library":
        imagePicker.sourceType = .photoLibrary
        break
      case "camera":
        imagePicker.sourceType = .camera
        break
      default:
        break
      }
      viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    private func alertForOpenPermissionSettings(isForCamera: Bool, completion: @escaping (Bool) -> Void) {
      
      let message = isForCamera == true ? NEVER_HAVE_CAMERA_ACCESS : NEVER_HAVE_LIBRARY_ACEESS
      let alert = UIAlertController(title: "Bundle.appName(", message: message, preferredStyle: .alert)
        let ok  = UIAlertAction(title: "Settings" ,style: .default) { _ in
          DispatchQueue.main.async {
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
            
            UIApplication.shared.open(settingsUrl)
          }
        }
    
      let dismiss = UIAlertAction(title: "Cancel" ,style: .cancel) { _ in
        
        completion(false)
      }
      alert.addAction(ok)
      alert.addAction(dismiss)
      
      UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
      
      let status = AVCaptureDevice.authorizationStatus(for: .video)
      switch status {
      case .authorized:
        completion(true)
      case .denied, .restricted:
        self.alertForOpenPermissionSettings(isForCamera: true, completion: { (status) in
          if !status {
            completion(false)
          }
        })
        
      case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
          if granted {
            completion(true)
          } else {
            completion(false)
          }
        })
      }
    }
    
    private func checkLibraryPermission(completion: @escaping (Bool) -> Void) {
      
      let status = PHPhotoLibrary.authorizationStatus()
      switch status {
      case .authorized, .limited:
        
        completion(true)
      case .denied, .restricted :
        self.alertForOpenPermissionSettings(isForCamera: false, completion: { (status) in
          if !status {
            completion(false)
          }
        })
        
        break
      case .notDetermined:
        // ask for permissions
        PHPhotoLibrary.requestAuthorization { status in
          switch status {
          case .authorized, .limited:
            completion(true)
            
            break
          case .denied, .restricted:
            
            completion(false)
            break
          case .notDetermined:
            
            completion(false)
            break
            
          @unknown default:
              completion(false)
              break
          }
        }
      @unknown default:
          completion(false)
          break
      }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      if let chosenImage = info[.editedImage] as? UIImage {
        if delegate != nil{
          delegate?.selectedImage(image: chosenImage)
        }
      } else{
        print("Something went wrong")
      }
      
      picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      if delegate != nil {
        delegate?.cancelToSelectImage()
      }
      picker.dismiss(animated: true, completion: nil)
    }
  }
