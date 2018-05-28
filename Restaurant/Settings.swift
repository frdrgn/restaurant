//
//  Settings.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 23/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import Foundation

struct Settings: Codable {
    static var shared = Settings()
    var ipAddress: String = ""
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("settings").appendingPathExtension("plist")
    
    static func saveSettings(settings: Settings) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedSettings = try? propertyListEncoder.encode(settings)
        try? encodedSettings?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSettings() -> Settings? {
        let propertyListDecoder = PropertyListDecoder()
        if let loadedData = try? Data(contentsOf: archiveURL) {
            let decodedSettings = try? propertyListDecoder.decode(Settings.self, from: loadedData)
            return decodedSettings
        }
        return nil
    }
}
