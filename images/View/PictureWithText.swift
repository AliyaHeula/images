//
//  PictureWithText.swift
//  images
//
//  Created by Aliya on 18.09.2023.
//

import SwiftUI

struct PictureWithText: View {
    
    @ObservedObject var mainScreenViewModel:MainScreenViewModel
    
    init(mainScreenViewModel: MainScreenViewModel) {
        self.mainScreenViewModel = mainScreenViewModel
    }
    
    var body: some View {
        VStack(alignment: .center) {
            NavigationLink {
                PictureView(uiImage: mainScreenViewModel.uiImage!)
            } label: {
                Image(uiImage: mainScreenViewModel.uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300, alignment: .center)
                    .clipped()
                    .cornerRadius(16)
            }
            VStack(alignment: .leading) {
                Text(mainScreenViewModel.authorName == "" ? "" : "by: \(mainScreenViewModel.authorName)")
                Text("on: Unsplash.com")
            }.frame(maxWidth: 250, alignment: .leading)
                .padding()
        }
    }
}

