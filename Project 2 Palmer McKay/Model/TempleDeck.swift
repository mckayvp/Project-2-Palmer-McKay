//
//  TempleDeck.swift
//  Project 2 Palmer McKay
//
//  Created by McKay Palmer on 10/11/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import Foundation

struct TempleDeck {
    private var cards: [TempleCard] = []
    
    init() {
        cards.append(TempleCard(filename: "apia-samoa-temple-lds-460475-mobile.jpg",
                                name: "Apia Samoa"));
        cards.append(TempleCard(filename: "billings-temple-lds-946466-mobile.jpg",
                                name: "Billings Montana"));
        cards.append(TempleCard(filename: "brigham-city-utah-temple-dedication-day-1027033-mobile.jpg",
                                name: "Brigham City Utah"));
        cards.append(TempleCard(filename: "brisbane-australia-temple-lds-745088-mobile.jpg",
                                name: "Brisbane Australia"));
        cards.append(TempleCard(filename: "calgary-alberta-temple-before-open-house-1033408-mobile.jpg",
                                name: "Calgary Alberta"));
        cards.append(TempleCard(filename: "cebu-philippines-temple-lds-852837-mobile.jpg",
                                name: "Cebu City Philippines"));
        cards.append(TempleCard(filename: "chicago-temple-lds-885844-mobile.jpg",
                                name: "Chicago Illinois"));
        cards.append(TempleCard(filename: "columbia-river-temple-lds-761262-mobile.jpg",
                                name: "Columbia River Washington"));
        cards.append(TempleCard(filename: "columbia-temple-lds-83400-mobile.jpg",
                                name: "Columbia South Carolina"));
        cards.append(TempleCard(filename: "columbus-temple-lds-406110-mobile.jpg",
                                name: "Columbus Ohio"));
        cards.append(TempleCard(filename: "copenhagen-denmark-temple-895949-mobile.jpg",
                                name: "Copenhagen Denmark"));
        cards.append(TempleCard(filename: "dallas-temple-lds-850748-mobile.jpg",
                                name: "Dallas Texas"));
        cards.append(TempleCard(filename: "denver-temple-lds-999518-mobile.jpg",
                                name: "Denver Colorado"));
        cards.append(TempleCard(filename: "detroit-temple-lds-837623-mobile.jpg",
                                name: "Detroit Michigan"));
        cards.append(TempleCard(filename: "draper-utah-lds-temple-1079449-mobile.jpg",
                                name: "Draper Utah"));
        cards.append(TempleCard(filename: "helsinki-finland-temple-lds-354503-mobile.jpg",
                                name: "Helsinki Finland"));
        cards.append(TempleCard(filename: "kyiv-ukraine-temple-lds-774302-mobile.jpg",
                                name: "Kyiv Ukraine"));
        cards.append(TempleCard(filename: "hawaii-temple-761091-mobile.jpg",
                                name: "Laie Hawaii"));
        cards.append(TempleCard(filename: "madrid-spain-temple-954939-mobile.jpg",
                                name: "Madrid Spain"));
        cards.append(TempleCard(filename: "mexico-city-temple-lds-591669-mobile.jpg",
                                name: "Mexico City Mexico"));
        
    }
    
    subscript(index: Int) -> TempleCard {
        get {
            return cards[index]
        }
        set {
            cards[index] = newValue
        }
    }
    
    var count: Int {
        return cards.count
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}
