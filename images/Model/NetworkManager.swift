//
//  NetworkManager.swift
//  images
//
//  Created by Aliya on 17.09.2023.
//

import Foundation
import SwiftUI
import Network

class NetworkManager {
    let monitor = NWPathMonitor()

    private(set) var isConnected = true

    init() {
        monitor.pathUpdateHandler = { path in
            Task{
                await MainActor.run {
                    self.isConnected = path.status == .satisfied
                }
            }
        }
        monitor.start(queue: .global())
    }
}
