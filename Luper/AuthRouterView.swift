//
//  AuthRouterView.swift
//  Luper
//
//  Created by Zandryn Epan on 4/8/25.
//

import SwiftUI

struct AuthRouterView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(destination: CreateAcc()) {
                    Text("Create an Account")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: LoginAcc()) {
                    Text("Login")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Lupér")
        }
    }
}

struct AuthRouterView_Previews: PreviewProvider {
    static var previews: some View {
        AuthRouterView()
    }
}
