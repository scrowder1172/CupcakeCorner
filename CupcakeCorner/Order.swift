//
//  Order.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/13/23.
//

import Foundation

@Observable
class Order {
    static let types: [String] = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type: Int = 0
    var quantity: Int = 3
    
    var specialRequestEnabled: Bool = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    
    var name: String = ""
    var streetAddres: String = ""
    var city: String = ""
    var zipCode: String = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddres.isEmpty || city.isEmpty || zipCode.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cupcake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more (array types has cakes in order of complication)
        cost += Decimal(type) / 2
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) * 0.5
        }
        
        return cost
    }
}
