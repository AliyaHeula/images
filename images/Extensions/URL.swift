//
//  URL.swift
//  images
//
//  Created by Aliya on 15.09.2023.
//

import Foundation

extension URL {
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }
}
