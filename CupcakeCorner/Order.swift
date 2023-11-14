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
    var streetAddress: String = ""
    var city: String = ""
    var zipCode: String = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zipCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        if let nameEncoded = try? JSONEncoder().encode(name) {
            UserDefaults.standard.set(nameEncoded, forKey: "Name")
        }
        
        if let streetAddressEncoded = try? JSONEncoder().encode(streetAddress) {
            UserDefaults.standard.set(streetAddressEncoded, forKey: "StreetAddress")
        }
        
        if let cityEncoded = try? JSONEncoder().encode(city) {
            UserDefaults.standard.set(cityEncoded, forKey: "City")
        }
        
        if let zipCodeEncoded = try? JSONEncoder().encode(zipCode) {
            UserDefaults.standard.set(zipCodeEncoded, forKey: "ZipCode")
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
    
    init() {
        name = Order.retrieveSavedSetting(property: "Name")
        streetAddress = Order.retrieveSavedSetting(property: "StreetAddress")
        city = Order.retrieveSavedSetting(property: "City")
        zipCode = Order.retrieveSavedSetting(property: "ZipCode")
    }
    
    static func retrieveSavedSetting(property: String) -> String {
        if let savedSetting = UserDefaults.standard.data(forKey: property) {
            if let decodedSetting = try? JSONDecoder().decode(String.self, from: savedSetting) {
                return decodedSetting
            }
        }
        return ""
    }
}
