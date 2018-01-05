//
//  NudityDetectorDelegate.swift
//  Core ML After Dark
//
//  Created by Derek Andre on 1/4/18.
//  Copyright © 2018 Derek Andre. All rights reserved.
//

import Foundation

protocol NudityDetectorDelegate {
    func nudityDetectorResults(doesContainNudity: Bool, confidence: Float)
}
