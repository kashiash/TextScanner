

import SwiftUI

struct TextPreviewView: View {
    var vm: TextItem
    @State var selectedView = 1
    var body: some View {
        TabView(selection: $selectedView) {
            ScrollView{
                if let image = vm.image {
                    
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
            .padding()
            .tabItem {
                Label("First", systemImage: "doc.text.image")
            }
            .tag(1)
            
            VStack {
                ScrollView {
                    
                    
                    Text(vm.text)
                        .font(.body)
                        .padding()
                }
            }
            .padding()
            .tabItem {
                Label("Second", systemImage: "text.magnifyingglass")
            }
            .tag(2)
        }
        

    }
}


