//
//  Item.swift
//  ToolsS3
//
//  Created by Igor Pustylnick on 2017-08-05.
//  Copyright © 2017 Your Developer. All rights reserved.
//

import UIKit

class Item : NSObject {
    var name : String
    var valueInDollars : Int
    var serialNumber: String?
    var dateCreated: Date
    
    init(name: String, valueInDollars: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random  {
            let adjectives = ["Steel", "Aluminum", "Titan"]
            let nouns = ["Pliers", "Hammer", "Screwdriver"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerial = UUID().uuidString.components(separatedBy:"-").first!
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerial)
            
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil)
        }
    }
}
