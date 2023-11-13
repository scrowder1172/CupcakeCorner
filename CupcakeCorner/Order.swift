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
}
