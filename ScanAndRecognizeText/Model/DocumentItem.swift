

import Foundation
import SwiftUI



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




class RecognizedDocument: ObservableObject {
    @Published var items = [DocumentItem]()
}
