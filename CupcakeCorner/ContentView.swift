//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Go To Async Call", destination: AsynchronousExample())
                .padding(.horizontal, 20)
                .frame(width: 200, height: 200)
                .border(.secondary)
            NavigationLink("Go To Haptic Effect", destination: HapticEffectsExample())
                .padding(.horizontal, 20)
                .frame(width: 200, height: 200)
                .border(.secondary)
            
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
