//
//  Item.swift
//  RMCharacters
//
//  Created by andres padilla on 22/02/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
