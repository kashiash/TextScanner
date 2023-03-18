//
//  Picker.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 18/03/2023.
//

import Foundation
import UIKit

enum Picker {
    enum Source: String {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}
