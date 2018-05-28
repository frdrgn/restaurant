//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 22/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
