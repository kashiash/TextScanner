

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
    var name: String = "Scaned document"
    var text: String = ""
    var createDate: Date
    var pages: [TextItem]
    
    init(){
        id = UUID().uuidString
        createDate = .now
        pages = [TextItem]()
    }
    
    var viewCreateDate: String {
        createDate.formatted(date: .numeric, time: .omitted) 
    }
}


class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}

class RecognizedDocument: ObservableObject {
    @Published var items = [DocumentItem]()
}
