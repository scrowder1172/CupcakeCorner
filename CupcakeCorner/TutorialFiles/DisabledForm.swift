//
//  DisabledForm.swift
//  CupcakeCorner
//
//  Created by SCOTT CROWDER on 11/10/23.
//

import SwiftUI

struct DisabledForm: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    
    @State private var disableView: Bool = false
    
    var formValidation: Bool {
        
        guard username.count >= 5 else { return true}
        
        guard email.contains("@") else {return true}
        
        return false
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
                    .disabled(disableView)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...\(username.count)")
                }
                .disabled(formValidation)
                
                Button("This is enabled when both fields have data") {
                    print("Creating account...")
                }
                .disabled(username.isEmpty || email.isEmpty)
                
                Button(disableView ? "Enable Views" : "Disable Views") {
                    disableView.toggle()
                    email = disableView ? "This is disabled until you re-enable it" : ""
                }
            }
        }
    }
}

#Preview {
    DisabledForm()
}
