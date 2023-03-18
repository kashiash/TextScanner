//
//  DocumentDetailView.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 18/03/2023.
//

import SwiftUI
import PhotosUI

struct DocumentDetailView: View {
    
    @ObservedObject var recognizedDocument: DocumentItem
    
    @State private var showScanner = false
        
    @State var selectedPhotos: [PhotosPickerItem] = []
    
    func processPhoto(photo: PhotosPickerItem){

        photo.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        if let data, let image = UIImage(data: data){
                            //self.loadedImages.append(.init(image: Image(uiImage: image), data: data))
                            let page = TextItem()
                            page.image = image
                            recognizedDocument.pages.append(page)
                        }
                    case .failure(let failure):
                        print(failure)
                }
            }
        }
    }
    
    
    
    var body: some View {
        VStack{
            VStack{
                Text(String(recognizedDocument.name))
                
                Text(String(recognizedDocument.viewCreateDate))
            }
            NavigationView {
                
                TabView{
                    ForEach(recognizedDocument.pages, id: \.id ){ page in
                        
                        if let image = page.image {
                            
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
                .tabViewStyle(.page)
                .frame(height: 650)
            }
            .onChange(of: selectedPhotos) { pickerItems in
                for photo in pickerItems{
                    processPhoto(photo: photo)
                }
            }
            .navigationTitle("Text Document")
            .toolbar {

                PhotosPicker(selection: $selectedPhotos, matching: .any(of: [.images]),photoLibrary: .shared()) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.callout)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showScanner = true
            }, label: {
                    Image(systemName: "doc.text.viewfinder")
                        .font(.callout)
            }))

           
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






