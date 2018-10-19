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
    var title: String = ""
    var region: String = ""
    var isStudyMode = false
    
    // MARK: - Init
    init() {
        // By default this builds a Temple Card
    }
    
    init(filename: String, name: String, title: String, region: String) {
        self.filename = filename
        self.name = name
        self.title = title
        self.region = region
    }
}
