//
//  Cupcake.swift
//  CupCakeProj
//
//  Created by Alan Yanovich on 2024-01-02.
//

import Foundation
import SwiftUI

@Observable
class Order: Codable {
    
    func isBlank(_ string: String) -> Bool {
      for character in string {
        if !character.isWhitespace {
            return false
        }
      }
      return true
    }

    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    var hasValidAddress: Bool {
        if name.isEmpty || isBlank(name) || streetAddress.isEmpty || isBlank(streetAddress) || city.isEmpty || isBlank(city) || zip.isEmpty || isBlank(zip) {
            return false
        }

        return true
    }
    
    var type = 0
    var quantity = 0
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
    
}
