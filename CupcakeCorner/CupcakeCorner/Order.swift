//
//  Order.swift
//  CupcakeCorner
//
//  Created by Johnny Wellington on 18/06/21.
//

import Foundation


struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate" , "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasInvalidAddress: Bool {
        return name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty ||
            name.trimmingCharacters(in: .whitespaces) == "" ||
            streetAddress.trimmingCharacters(in: .whitespaces) == "" ||
            city.trimmingCharacters(in: .whitespaces) == "" ||
            zip.trimmingCharacters(in: .whitespaces) == ""
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/coke for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/ cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    
    init() { }
}


class OrderWrapper: ObservableObject {
    @Published var order: Order
        
    init() {
        self.order = Order()
    }
    
}
