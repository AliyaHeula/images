//
//  MainScreenView.swift
//  images
//
//  Created by Aliya on 10.09.2023.
//
import Foundation
import SwiftUI

struct MainScreenView: View {
    @State var uiImage: UIImage?
    @State var imageToShow = Image(systemName: "figure.mind.and.body")
    let tmp = ImageToShow()

    @State private var showingAlert = false
    @State private var alertText = ""
//    "Something went wrong.\nPlease try again later..."
    @State private var isBackwardDisabled = true

    
    var body: some View {
        NavigationStack{
            VStack {
                if let uiImage = uiImage {
                    VStack(alignment: .center) {
                        NavigationLink{
                            PictureView(uiImage: uiImage)
                        } label: {
                            Image(uiImage: uiImage)
                                .resizable()
                                .cornerRadius(16)
                                .scaledToFit()
                                .frame(width: 300, height: 300)

                        }
                    }
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .cornerRadius(16)
                }
                HStack {
                    Button(action: cachedImages) {
                        Image(systemName: "chevron.backward.square")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(0.6)
                    }.disabled(isBackwardDisabled)
                    Button(action: updateImage) {
                        Image(systemName: "chevron.forward.square")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(0.6)
                    }.alert(alertText, isPresented: $showingAlert) {}
                }
            }
        }
    }

    func cachedImages() {
        Task {
            do {
                uiImage = try await tmp.getPreviousPicture()
            } catch {
                switch error {
                case NetworkErrors.onTheTopOfCache:
                    isBackwardDisabled = true
                default:
                    alertText = "Cache images issue"
                    showingAlert = true
                    print(error)
                }
            }
        }
    }


    func updateImage(){
        Task {
            do {
                uiImage = try await tmp.getPicture()
                isBackwardDisabled = false
                //                uiImage = try await tmp.testAlerts()
            } catch {
                switch error {
                case NetworkErrors.limitExceed:
                    alertText = "Request limit exceeded. Please try again in next hour"
                case NetworkErrors.accessDenied:
                    alertText = "Access is denied"
                default:
                    alertText = "Other issues details"
                }
                showingAlert = true
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
