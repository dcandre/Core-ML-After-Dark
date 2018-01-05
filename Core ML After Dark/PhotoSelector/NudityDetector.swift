//
//  NudityDetector.swift
//  Core ML After Dark
//
//  Created by Derek Andre on 1/4/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import Foundation
import CoreML
import Vision

class NudityDetector {
    
    var delegate:NudityDetectorDelegate?
    
    func doesContainNudity(_ ciImage:CIImage) {
        
        guard let vnCoreMLModel = try? VNCoreMLModel(for: Nudity().model) else {
            
            fatalError("The Core ML model could not be loaded.")
            
        }
        
        let vnCoreMLRequest = VNCoreMLRequest(model: vnCoreMLModel) { (vnRequest, error) in
            
            guard let vnClassificationObservations = vnRequest.results as? [VNClassificationObservation] else {
                fatalError("The image could not be processed by the model.")
            }
            
            if let firstObservation = vnClassificationObservations.first {
                
                print(firstObservation.identifier)
                
                let doesContainNudity = (firstObservation.identifier == "NSFW") ? true : false
                
                if let nudityDetectorDelegate = self.delegate {
                    
                    nudityDetectorDelegate.nudityDetectorResults(doesContainNudity: doesContainNudity, confidence: firstObservation.confidence)
                    
                }
                
            }
            
        }
        
        let vnImageRequestHandler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            
            try vnImageRequestHandler.perform([vnCoreMLRequest])
            
        }
        catch {
            
            print(error)
            
        }
    }
}
