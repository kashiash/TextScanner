//
//  ImageSliderView.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 18/03/2023.
//

import SwiftUI

struct ImageSliderView: View {
    @State var recognizedDocument: DocumentItem
    var body: some View {

        TabView {
        
            ForEach(recognizedDocument.pages, id: \.id){ item in
                ZStack{
                    if let image = item.image {
                        
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
                    .tabItem {
                        Label("", systemImage: "0\(item.pageNumber).square")
                    }
                    .tag(item.pageNumber)
   
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}


