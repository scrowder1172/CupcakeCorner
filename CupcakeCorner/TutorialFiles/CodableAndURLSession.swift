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
        NavigationStack {
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("Taylor Swift")
        }
    }
    
    func loadData() async {
        // create URL to read from
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        // fetch data from URL
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            // decode data and display
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
        
    }
}

#Preview {
    CodableAndURLSession()
}
