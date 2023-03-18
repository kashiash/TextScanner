    //
    //  DocumentDetailView.swift
    //  ScanAndRecognizeText
    //
    //  Created by Jacek Kosiński G on 18/03/2023.
    //

import SwiftUI

struct DocumentDetailView2: View {
    @ObservedObject var recognizedDocument: DocumentItem
    
    
    @State private var showScanner = false
    
    var body: some View {
        VStack{
            VStack{
                Text(String(recognizedDocument.name))
                
                Text(String(recognizedDocument.viewCreateDate))
            }
            NavigationView {
                
                ScrollView(.horizontal){
                    LazyHStack(spacing: 10){
                        ForEach(recognizedDocument.pages, id: \.id) { textItem in
                            NavigationLink(destination: TextPreviewView(vm: textItem)) {
                                if let image = textItem.image {
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                    
                                } else {
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .opacity(0.6)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 800)
                
                    //            ZStack(alignment: .bottom) {
                    //                List(recognizedDocument.pages, id: \.id) { textItem in
                    //                    NavigationLink(destination: TextPreviewView(vm: textItem)) {
                    //                        Text(String(textItem.text.prefix(50)).appending("..."))
                    //                    }
                    //                }
                    //            }
                
            }
            
            .navigationTitle("Text Document")
            .navigationBarItems(trailing: Button(action: {
                showScanner = true
            }, label: {
                HStack {
                    Image(systemName: "doc.text.viewfinder")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    
                    Text("Scan")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .frame(height: 36)
                .background(Color(UIColor.systemIndigo))
                .cornerRadius(18)
            }))
        }
        
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                    case .success(let scannedImages):
                        
                        for image in scannedImages {
                            let page = TextItem()
                            page.image = image
                            recognizedDocument.pages.append(page)
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                }
                
                showScanner = false
                
            } didCancelScanning: {
                    // Dismiss the scanner controller and the sheet.
                showScanner = false
            }
        })
        
    }
}






