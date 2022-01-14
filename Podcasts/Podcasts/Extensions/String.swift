//
//  String.swift
//  Podcasts
//
//  Created by sky on 1/13/22.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
