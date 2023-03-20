//
//  EditDocumentView.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 19/03/2023.
//

import SwiftUI

struct EditDocumentView: View {
    @ObservedObject var document: DocumentItem
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $document.name, prompt: Text("Enter the issue title here"))
                        .font(.title)
                    
                    Text("**Modified:** \(document.createDate.formatted(date: .long, time: .shortened))")
                        .foregroundStyle(.secondary)
                }
            }
            Section {
                VStack(alignment: .leading) {
                    Text("Basic Information")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    TextField("Content", text: $document.text, prompt: Text("Documents content here"), axis: .vertical)
                }
            }
//            Section {
//                ForEach(document.pages, id: \.id) { item in
//                    Text(item.name)
//                    Text(item.pageNumber)
//                }
//                //.onDelete(perform: removeItems)
//            }
            
        }
    }
}


