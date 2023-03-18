//
//  TextItem.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 18/03/2023.
//

import Foundation
import SwiftUI

class TextItem: ObservableObject {
    var id: String
    var text: String = ""
    var image: UIImage?
    var pageNumber: Int = 0
    init() {
        id = UUID().uuidString
    }
}

class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}
