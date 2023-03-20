//
//  PageDetailView.swift
//  ScanAndRecognizeText
//
//  Created by Jacek Kosiński G on 19/03/2023.
//

import SwiftUI

struct PageDetailView: View {
    @ObservedObject var page: TextItem
    var body: some View {
        Text(page.text)
        if let image = page.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width - 30, height: getRect().height - 30)
                .cornerRadius(15)
                .addPinchZoom()
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

//struct PageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageDetailView()
//    }
//}
