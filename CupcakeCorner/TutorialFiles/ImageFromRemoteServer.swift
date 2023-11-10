//
//  ImageFromRemoteServer.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/10/23.
//

import SwiftUI

struct ImageFromRemoteServer: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                HStack {
                    Image(systemName: "iphone.slash.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("The was an error loading the image.")
                }
                .foregroundStyle(.red)
                
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    ImageFromRemoteServer()
}
