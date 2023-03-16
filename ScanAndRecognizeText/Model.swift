

import Foundation
import SwiftUI

class TextItem: ObservableObject {
    var id: String
    var text: String = ""
    var image: UIImage?
    
    init() {
        id = UUID().uuidString
    }
}


class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}
