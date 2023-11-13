//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var order: Order = Order()
    
    @State private var showingOrderDetails: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Cake Info") {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section("Special Requests") {
                    Toggle("Special Requests", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section("Delivery") {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
            .toolbar {
                Button {
                    showingOrderDetails = true
                } label: {
                    Label("See Order", systemImage: "printer.fill")
                }
            }
            .sheet(isPresented: $showingOrderDetails) {
                OrderDetails(order: order)
            }
        }
    }
}

struct OrderDetails: View {
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
                    Text("Street Address: \(order.streetAddres)")
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
    ContentView()
}
