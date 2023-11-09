//
//  CodableAndPublished.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/9/23.
//

import SwiftUI

class User: ObservedObject, Codable {
    var name: String = "Paul Hudson"
}

struct CodableAndPublished: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


@Observable
class Model {
    var myString: String = "Hello"
}

struct MediumArticle: View {
    @State var model: Model
    @State private var changeText: Bool = true

        var body: some View {
            VStack {
                Text("myString: \(model.myString)")
                Button("Hit me") {
                    changeText.toggle()
                    if changeText {
                        model.myString = "new"
                    } else {
                        model.myString = "old"
                    }
                }
            }
        }
}

#Preview {
    let model: Model = Model()
    //CodableAndPublished()
    return MediumArticle(model: model)
}
