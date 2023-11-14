//
//  OrderDetailsView.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/13/23.
//

import SwiftUI

struct OrderDetailsView: View {
    var order: Order
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Order Details:")
                    .font(.title)
                    .padding(.bottom)
                Text("Cake Type: \(Order.types[order.type])")
                    .padding(.bottom)
                
                Text("Cupcake Quantity: \(order.quantity)")
                    .padding(.bottom)
                
                HStack {
                    Text("Special Requests:")
                    Image(systemName: order.specialRequestEnabled ? "checkmark.circle" : "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(order.specialRequestEnabled ? .green : .red)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Extra Frosting:")
                    Image(systemName: order.extraFrosting ? "checkmark.circle" : "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(order.extraFrosting ? .green : .red)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Add Sprinkles:")
                    Image(systemName: order.addSprinkles ? "checkmark.circle" : "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(order.addSprinkles ? .green : .red)
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Customer Details")
                        .font(.title)
                        .padding(.bottom)
                    
                    Text("Name: \(order.name)")
                        .padding(.bottom)
                    Text("Street Address: \(order.streetAddress)")
                        .padding(.bottom)
                    Text("City: \(order.city)")
                        .padding(.bottom)
                    Text("Zip Code: \(order.zipCode)")
                        .padding(.bottom)
                }
                .padding(.bottom)
                
                Button("Done") {dismiss()}
                    .padding()
                    .frame(width: 200, height: 50)
                    .foregroundStyle(.white)
                    .background(.cyan)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
        
    }
}

#Preview {
    OrderDetailsView(order: Order())
}
