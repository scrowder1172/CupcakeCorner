//
//  AsynchronousExample.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/10/23.
//

import SwiftUI

struct AsynchronousExample: View {
    
    @State private var superMessage: String = "We're going to have some fun!"
    @State private var workingMessage: String = "Waiting..."
    
    @State private var progress: Double = 0.0
    @State private var clickCount: Int = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .padding(.horizontal, 10)
                
                Text("This is an example of an asynchronous function. Click 'Start' to begin the async func. A message will appear and a progress bar will be updated. When the update is finished, the message will change. In the meantime, you can click 'Click Me' to update the counter at the bottom of the screen while the async function is running.")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .padding(.horizontal, 10)
                
                HStack {
                    Button("Start") {
                        Task {
                            await printMessage()
                        }
                    }
                    .frame(width: 100, height: 50)
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    Button("Reset") {
                        superMessage = "We're going to have some fun!"
                        progress = 0.0
                        workingMessage = "Waiting..."
                        clickCount = 0
                    }
                        .frame(width: 100, height: 50)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 20))
                    Button("Click me") {
                        clickCount += 1
                    }
                    .frame(width: 100, height: 50)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 20))
                }
                .padding(.vertical, 10)
                
                ProgressView(workingMessage, value: progress, total: 100)
                                .padding()
                
                Text(superMessage)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .border(.black)
                    .padding(.horizontal, 20)
                
                Text("Click Counter: \(clickCount)")
            }
            .navigationTitle("Asynchronous Call")
        }
        
    }
    
    func printMessage() async {
        superMessage = "Hello from the great beyond! I am now going to sleep..."
        workingMessage = "Working..."
        for _ in 0..<100 {
            try? await Task.sleep(nanoseconds: 20_000_000) // Sleep for a short period
            progress += 1
        }
        
        superMessage += "I'm back awake!"
        workingMessage = "Working...Done!"
    }
    
}

#Preview {
    AsynchronousExample()
}
