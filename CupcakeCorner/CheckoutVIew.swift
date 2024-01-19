//
//  CheckoutVIew.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/13/23.
//

import SwiftUI

struct CheckoutVIew: View {
    var order: Order
    
    @State private var statusMessage: String = ""
    
    @State private var showingOrderDetails: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                
                Text(statusMessage)
                    .font(.system(size: 20).bold())
                    .padding()
            }
        }
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            Button {
                showingOrderDetails = true
            } label: {
                Label("See Order", systemImage: "printer.fill")
            }
        }
        .sheet(isPresented: $showingOrderDetails) {
            OrderDetailsView(order: order)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            statusMessage = "Failed to encode order"
            print(statusMessage)
            return
        }
        
        let url: URL = URL(string: "https://reqres.in/api/cupcakes")!
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            statusMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way"
        } catch {
            statusMessage = "Checkout failed: \(error.localizedDescription)"
            print(statusMessage)
        }
    }
}

#Preview {
    CheckoutVIew(order: Order())
}
