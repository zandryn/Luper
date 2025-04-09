//
//  Home.swift
//  Luper
//
//  Created by Zandryn Epan on 4/8/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Home: View {
    @AppStorage("is_logged_in") private var is_logged_in = false
    @AppStorage("curr_username") private var username = ""

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack(alignment: .bottomTrailing) {
                    VStack {
                        // welcome title
                        VStack(alignment: .leading) {
                            Text("HIII \(username)!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top, 40)
                                .padding(.horizontal)
                        }
                        Spacer() // confirm login WILL REMOVE later
                        VStack(spacing: 10) {
                            Text("🐛LUPÉR HOME SCREEN🐛")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            
                            Button("Log Out") {
                                try? Auth.auth().signOut()
                                is_logged_in = false
                            }
                            .foregroundColor(.blue)
                        }
                        Spacer()
                    }

                    // add new entry button 
                    NavigationLink(destination: Record()) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.purple)
                            .padding()
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
