//
//  TempleCard.swift
//  Project 2 Palmer McKay
//
//  Created by McKay Palmer on 10/11/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import Foundation

struct TempleCard {
    
    // MARK: - Properties
    var filename: String = ""
    var name: String = ""
    
    // MARK: - Init
    init() {
        // By default this builds a Temple Card
    }
    
    init(filename: String, name: String) {
        self.filename = filename
        self.name = name
    }
}
