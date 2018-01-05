//
//  ImageSelector.swift
//  Core ML After Dark
//
//  Created by Derek Andre on 1/4/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import Foundation
import UIKit

class ImageSelector: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let uiImagePickerController = UIImagePickerController()
    
    var delegate: ImageSelectorDelegate?
    
    func showCamera(parentUIViewController:UIViewController) {
        showImageSelector(uiImagePickerControllerSourceType: .camera, parentUIViewController: parentUIViewController)
    }
    
    func showPhotoLibrary(parentUIViewController:UIViewController) {
        showImageSelector(uiImagePickerControllerSourceType: .photoLibrary, parentUIViewController: parentUIViewController)
    }
    
    func hideImageSelector() {
        
        uiImagePickerController.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userSelectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if let imageSelectorDelegate = delegate {
                
                imageSelectorDelegate.imageSelected(selectedImage: userSelectedImage)
                
            }
            
        }
        
    }
    
    private func showImageSelector(uiImagePickerControllerSourceType:UIImagePickerControllerSourceType, parentUIViewController:UIViewController) {
        
        if (UIImagePickerController.isSourceTypeAvailable(uiImagePickerControllerSourceType)) {
            
            uiImagePickerController.sourceType = uiImagePickerControllerSourceType
            uiImagePickerController.delegate = self
            uiImagePickerController.allowsEditing = true
            
            parentUIViewController.present(uiImagePickerController, animated: true, completion: nil)
            
        }
        
    }
    
}
