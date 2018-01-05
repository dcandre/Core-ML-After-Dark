//
//  NudityDetectorAlert.swift
//  Core ML After Dark
//
//  Created by Derek Andre on 1/4/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import Foundation
import UIKit

class NudityDetectorAlert: UIAlertController {
    
    private var alertWindow:UIWindow?
    
    func show(title:String, message:String) {
        
        let uiAlertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
        
        uiAlertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            
            self.hide()
            
        }))
        
        alertWindow = UIWindow(frame: UIScreen.main.bounds)
        
        if let uiWindow = alertWindow {
            
            uiWindow.rootViewController = UIViewController()
            uiWindow.makeKeyAndVisible()
            
            if let rootViewController = uiWindow.rootViewController {
                rootViewController.present(uiAlertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func hide() {
        
        if let uiWindow = alertWindow {
            uiWindow.isHidden = true
            alertWindow = nil
        }
        
    }
    
}

