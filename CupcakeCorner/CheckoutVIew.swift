//
//  CheckoutVIew.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/13/23.
//

import SwiftUI

struct CheckoutVIew: View {
    var order: Order
    
    var body: some View {
        Text("Let's checkout...")
    }
}

#Preview {
    CheckoutVIew(order: Order())
}
