//
//  MediaFile.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 18/03/2023.
//

import Foundation
import SwiftUI

struct MediaFile: Identifiable {
    var id: String = UUID().uuidString
    var image: Image
    var data: Data
}
