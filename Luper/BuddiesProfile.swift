//
//  BuddiesProfile.swift
//  Luper
//
//  Created by Zandryn Epan on 4/11/25.
//

import SwiftUI
import FirebaseFirestore

struct BuddiesProfile: View {
    var username: String
    
    @AppStorage("curr_username") private var curr_username = ""
    @State private var added = false

    var body: some View {
        VStack(spacing: 20) {
            Text("🐛")
                .font(.system(size: 60))

            Text(username)
                .font(.title)
                .fontWeight(.semibold)

            if added {
                Text("Already Buddies!")
                    .foregroundColor(.green)
                    .bold()
            } else {
                Button("Add Buddy") {
                    addBuddy()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(12)
            }
        }
        .padding()
        .navigationTitle("Buddy Profile")
    }

    func addBuddy() {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(curr_username)

        userRef.updateData([
            "buddies": FieldValue.arrayUnion([username])
        ]) { error in
            if let error = error {
                print("Failed to add buddy: \(error.localizedDescription)")
            } else {
                added = true
                print("💜 Buddy added successfully!")
            }
        }
    }
}

struct BuddiesProfile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BuddiesProfile(username: "epraudite")
        }
    }
}
