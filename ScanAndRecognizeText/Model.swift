

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

class DocumentItem: ObservableObject{
    var id:String
    var name: String = "Scaned docuemnt"
    var createDate: Date
    var pages: [TextItem]
    
    init(){
        id = UUID().uuidString
        createDate = Date.now()
        pages = [TextItem]()
    }
}


class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}
