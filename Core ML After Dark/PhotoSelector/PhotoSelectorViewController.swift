//
//  PhotoSelectorViewController.swift
//  Core ML After Dark
//
//  Created by Derek Andre on 1/3/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import UIKit


class PhotoSelectorViewController: UIViewController, ImageSelectorDelegate, NudityDetectorDelegate {
    
    private var imageSelector:ImageSelector?
    private var nudityDetector:NudityDetector?
    private let nudityDetectorAlert = NudityDetectorAlert()
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBAction func cameraButtonPushed(_ sender: UIBarButtonItem) {
        
        if let selector = imageSelector {
            selector.showCamera(parentUIViewController: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSelector = ImageSelector()
        
        if let selector = imageSelector {
            selector.delegate = self
        }
        
        nudityDetector = NudityDetector()
        
        if let detector = nudityDetector {
            detector.delegate = self
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        hideImageSelector()
        
        imageSelector = nil
        nudityDetector = nil
    }
    
    func imageSelected(selectedImage: UIImage) {
        
        selectedImageView.image = selectedImage
        
        guard let ciImage = CIImage(image: selectedImage) else {
            fatalError("The selected UIImage could not be converted to a CIImage.")
        }
        
        if let detector = nudityDetector {
            detector.doesContainNudity(ciImage)
        }
        
        hideImageSelector()
        
    }
    
    func nudityDetectorResults(doesContainNudity: Bool, confidence: Float) {
        
        print(doesContainNudity)
        print(confidence)
        
        if (doesContainNudity && confidence > 0.5) {
            
            self.navigationItem.title = ""
            
            showNudityDetectedAlert()
            
        }
        else {
            
            self.navigationItem.title = "SFW Photo, Probably"
            
        }
        
    }
    
    private func showNudityDetectedAlert() {
    
        nudityDetectorAlert.show(title:"NSFW Picture Detected!", message: "This picture will not be allowed on our platform.")
        
        self.selectedImageView.image = nil
    
    }
    
    private func hideImageSelector() {
        
        if let selector = imageSelector {
            selector.hideImageSelector()
        }
        
    }

}

