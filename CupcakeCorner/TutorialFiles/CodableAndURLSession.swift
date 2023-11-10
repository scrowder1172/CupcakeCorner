//
//  CodableAndPublished.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/9/23.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct CodableAndURLSession: View {
    @State private var results: [Result] = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
    }
}

#Preview {
    CodableAndURLSession()
}
