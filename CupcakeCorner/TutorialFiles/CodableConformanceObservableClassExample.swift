//
//  CodableConformanceObservableClassExample.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/13/23.
//

import SwiftUI

@Observable
class ObservableUser: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name: String = "Taylor"
}

struct CodableObservableExample: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data: Data = try! JSONEncoder().encode(ObservableUser())
        print(type(of: data))
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    CodableObservableExample()
}
