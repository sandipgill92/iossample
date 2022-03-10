//
//  PreviewViewController.swift
//  AppsMaven
//
//  Created by Sandip Gill on 19/07/21.
//

import UIKit
import QuickLook
class PreviewViewController:UIViewController, QLPreviewControllerDelegate, QLPreviewControllerDataSource{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let quickLookViewController = QLPreviewController()
        // 2
        quickLookViewController.delegate = self
        quickLookViewController.dataSource = self
        // 3
        quickLookViewController.currentPreviewItemIndex = 0
        // 4
        self.present(quickLookViewController, animated: true)
        
    }
    
    // saves an image, if save is successful, returns its URL on local storage, otherwise returns nil
    func saveImage(_ image: UIImage, name: String) -> URL? {
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            return nil
        }
        do {
            let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
            try imageData.write(to: imageURL)
            return imageURL
        } catch {
            return nil
        }
    }

    // returns an image if there is one with the given name, otherwise returns nil
    func loadImage(withName name: String) -> URL? {
        let imageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
        return imageURL
    }
    
    func previewController(
      _ controller: QLPreviewController,
      editingModeFor previewItem: QLPreviewItem
    ) -> QLPreviewItemEditingMode {
      .updateContents
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.saveImage(UIImage.init(named: "wallpaperflare")!, name: "temp") as! QLPreviewItem
    }
}
