//
//  Buddies.swift
//  Luper
//
//  Created by Zandryn Epan on 4/11/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct Buddy: Identifiable {
    let id: String // buddy usernames
    let pfp: String
}

struct Buddies: View {
    @State private var searchText = ""
    @State private var show_buddies_add = false

    var body: some View {
        VStack {
            // search bar w add friends button
            HStack {
                TextField("Search Buddies", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.leading)

                // ADD FRIENDS BUTTON
                Button(action: {
                    show_buddies_add = true
                }) {
                    Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.trailing)
                }
            }
            .padding(.top)

            Spacer()

            Text("🐛 This be your watch buds.")
                .foregroundColor(.secondary)

            Spacer()
        }
        .navigationTitle("✨Buddies✨")
        .sheet(isPresented: $show_buddies_add) {
            BuddiesAdd()
        }
    }
}

struct Buddies_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Buddies()
        }
    }
}
