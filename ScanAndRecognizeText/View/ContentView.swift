

import SwiftUI

struct ContentView: View {

    @ObservedObject var recognizedDocument = RecognizedDocument()
    
    
    @State private var showScanner = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List(recognizedDocument.items, id: \.id) { documentItem in
                    NavigationLink(destination: DocumentDetailView(recognizedDocument: documentItem)) {
                        Text(String(documentItem.text.prefix(50)).appending("..."))
                        Text(String(documentItem.name))
                        
                        Text(String(documentItem.viewCreateDate))
                    }
                    .contentShape(Rectangle())
                    
                }

            }
            .navigationTitle("Documents")
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
            .navigationBarItems(leading: addButton)
        }
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                    case .success(let scannedImages):

                        if scannedImages.count > 0 {
                            let document = DocumentItem()
                            for image in scannedImages {
                                let page = TextItem()
                                page.image = image
                                page.pageNumber = document.pages.count + 1
                                document.pages.append(page)
                            }
                            recognizedDocument.items.append(document)
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
    
    var addButton: some View {
        Button(action: {
            addNewDocument()
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
    
    func addNewDocument() {
        let newObject = DocumentItem()
        recognizedDocument.items.append(newObject)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
