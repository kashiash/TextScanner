//
//  DocumentDetailView.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 18/03/2023.
//

import SwiftUI
import PhotosUI
import PDFKit

struct DocumentDetailView: View {
    
    @ObservedObject var recognizedDocument: DocumentItem
    
    @State private var showScanner = false
    
    @State private var showDocumentEditor = false
        
    @State var selectedPhotos: [PhotosPickerItem] = []
    @State private var backgroundColor = Color.red
    @SceneStorage("isZooming") var isZooming: Bool = false
    
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
    
    func createPdf(pages: [TextItem]){
        let pdfDocument = PDFDocument()
        for (index,page) in pages.enumerated(){
                // Create a PDF page instance from your image
            if let image = page.image {
                let pdfPage = PDFPage(image: image)
                        // Insert the PDF page into your document
                    pdfDocument.insert(pdfPage!, at: index)
                }
            }
            
            
            let data = pdfDocument.dataRepresentation()
            
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let docURL = documentDirectory.appendingPathComponent("Scanned-Docs.pdf")
            
            do{
                try data?.write(to: docURL)
            }catch(let error){
                print("error is \(error.localizedDescription)")
            }
        }
    
    
    var body: some View {
        VStack{
            NavigationStack {
            if !isZooming {
                VStack {
                    Text(String(recognizedDocument.name))
                    Text(String(recognizedDocument.viewCreateDate))
                }
            }
           
           
                
                TabView{
                    ForEach(recognizedDocument.pages, id: \.id ){ page in
                        
                        
                        NavigationLink {
                            PageDetailView(page: page)
                        } label: {
                            if let image = page.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: getRect().width - 30, height: isZooming ? 850 : 650)
                                    .cornerRadius(15)
                                    .addPinchZoom()
                                    .contextMenu {
                                        Button(action: {
                                            self.showDocumentEditor = true
                                        }, label: {
                                            HStack {
                                                Text("Edit")
                                                Image(systemName: "pencil")
                                            }
                                        })
                                        
                                        Button("Green") {
                                            backgroundColor = .green
                                        }
                                        
                                        Button("Blue") {
                                            backgroundColor = .blue
                                        }
                                    }
                                
                            } else {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.6)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding(.horizontal)
                            }
                        }
//                        NavigationLink(destination: Text("Edit Mode View Here"), isActive: $showDocumentEditor) {
//                            EditDocumentView(document: recognizedDocument)
//                        }
                        
                        
                    }
                }
                .tabViewStyle(.page)
                .frame(height: isZooming ? 850 : 650)
                .background(backgroundColor)
            }
            .onChange(of: selectedPhotos) { pickerItems in
                for photo in pickerItems{
                    processPhoto(photo: photo)
                }
            }

            .toolbar {

                PhotosPicker(selection: $selectedPhotos, matching: .any(of: [.images]),photoLibrary: .shared()) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.callout)
                }
                
//                createPdf(pages: recognizedDocument.pages){
//                    Image(systemName: "doc.append")
//                        .font(.callout)
//                }
            }
            .navigationBarItems(trailing: Button(action: {
                showScanner = true
            }, label: {
                    Image(systemName: "doc.text.viewfinder")
                        .font(.callout)
            }))
//            .navigationBarItems(leading:  Button(action: {
//                showDocumentEditor = true
//            }, label: {
//                Image(systemName: "edit")
//                    .font(.callout)
//            }))
           
        }
            // Hiding Nav Bar...
       // .offset(y: isZooming ? -200 : 0)
        .animation(.easeInOut, value: isZooming)
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
        .sheet(isPresented: $showDocumentEditor, content: {
            EditDocumentView(document: recognizedDocument)
        })
        
    }
    
}






