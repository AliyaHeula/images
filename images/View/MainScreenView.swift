//
//  MainScreenView.swift
//  images
//
//  Created by Aliya on 10.09.2023.
//
import Foundation
import SwiftUI

struct MainScreenView: View {
    @ObservedObject var mainScreenViewModel = MainScreenViewModel()

    @State private var isShowingAlert = false
    @State private var connectionAlert = false
    @State private var isBackwardDisabled = true
    @State private var isForwardDisabled = false
    
    var body: some View {
        NavigationStack {
            if let _ = mainScreenViewModel.uiImage {
                PictureWithText(mainScreenViewModel: mainScreenViewModel)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(16)
            }
            HStack {
                Button(action: previousImages) {
                    Image(systemName: "chevron.backward.square")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .opacity(0.6)
                }.disabled(isBackwardDisabled)
                Button(action: nextImage) {
                    Image(systemName: "chevron.forward.square")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .opacity(0.6)
                }.alert(mainScreenViewModel.alertText, isPresented: $isShowingAlert) {}
                    .alert("Conection issue", isPresented: $connectionAlert) {}
                    .disabled(isForwardDisabled)
            }
        }
    }

    func previousImages() {
        Task {
            do {
                try await mainScreenViewModel.getPreviousPicture()
                isBackwardDisabled = mainScreenViewModel.isPreviousImageInactive
            } catch {
                isShowingAlert = true
                print(error)
            }
        }
    }

    func nextImage(){
        guard mainScreenViewModel.isConnected else {
            connectionAlert = true
            return
        }
        connectionAlert = false
        Task {
            do {
                isForwardDisabled = true
                try await mainScreenViewModel.getNextPicture()
                isBackwardDisabled = mainScreenViewModel.isPreviousImageInactive
            } catch {
                isShowingAlert = true
                print(error)
            }
            isForwardDisabled = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
