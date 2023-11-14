//
//  Order.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/13/23.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zipCode = "zipCode"
    }
    
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
    
    var name: String
    var streetAddress: String
    var city: String
    var zipCode: String
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        saveSetting(property: name, key: "Name")
        saveSetting(property: streetAddress, key: "StreetAddress")
        saveSetting(property: city, key: "City")
        saveSetting(property: zipCode, key: "ZipCode")
        
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
    
    init() {
        name = Order.retrieveSavedSetting(key: "Name")
        streetAddress = Order.retrieveSavedSetting(key: "StreetAddress")
        city = Order.retrieveSavedSetting(key: "City")
        zipCode = Order.retrieveSavedSetting(key: "ZipCode")
    }
    
    static func retrieveSavedSetting(key: String) -> String {
        if let savedSetting = UserDefaults.standard.data(forKey: key) {
            if let decodedSetting = try? JSONDecoder().decode(String.self, from: savedSetting) {
                return decodedSetting
            }
        }
        return ""
    }
    
    func saveSetting(property: String, key: String) {
        if let encoded = try? JSONEncoder().encode(property) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
