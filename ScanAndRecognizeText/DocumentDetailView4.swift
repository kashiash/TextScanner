//
//  DocumentDetailView4.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 18/03/2023.
//



import SwiftUI

struct DocumentDetailView4: View {
    @ObservedObject var recognizedDocument: DocumentItem
    
    @StateObject private var cvm = CameraViewModel()
    
    @State private var showScanner = false
    
    var body: some View {
        VStack{
            VStack{
                Text(String(recognizedDocument.name))
                
                Text(String(recognizedDocument.viewCreateDate))
            }
            NavigationView {
                
                List{
                    
                    ImageSliderView(recognizedDocument: recognizedDocument)
                        .frame(height: 800)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
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
            Spacer()
            HStack {
                Button {
                    cvm.source = .camera
                    cvm.showPhotoPicker()
                } label: {
                    Text("Camera")
                }
                Button {
                    cvm.source = .library
                    cvm.showPhotoPicker()
                } label: {
                    Text("Photos")
                }
            }
            
        }
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                    case .success(let scannedImages):
                        
                        for image in scannedImages {
                            let page = TextItem()
                            page.image = image
                            page.pageNumber = recognizedDocument.pages.count + 1
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






