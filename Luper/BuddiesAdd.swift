//
//  BuddiesAdd.swift
//  Luper
//
//  Created by Zandryn Epan on 4/11/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct BuddiesAdd: View {
    @State private var search_query = ""
    @State private var all_users: [String] = []
    @State private var filtered_results: [String] = []

    var body: some View {
        VStack {
            // search bar
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search users...", text: $search_query)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: search_query) { _, newValue in
                        filterResults(for: newValue)
                    }
            }
            .padding()

            // dropdown to match usernames
            List(filtered_results, id: \.self) { username in
                NavigationLink(destination: BuddiesProfile(username: username)) {
                    HStack {
                        Text("🐛")
                        Text(username)
                            .fontWeight(.medium)
                    }
                    .onTapGesture {
                        print("Navigating to profile of \(username)") // debugger
                    }
                }
            }

            Spacer()
        }
        .navigationTitle("Add a Buddy")
        .onAppear {
            Task {
                await fetchAllUsers()
            }
        }
    }

    // fetch all users & filter own username
    func fetchAllUsers() async {
        let db = Firestore.firestore()
        let curr_username = Auth.auth().currentUser?.displayName ?? ""

        do {
            let snapshot = try await db.collection("users").getDocuments()
            let allUsers = snapshot.documents.compactMap { $0["username"] as? String }
                .filter { $0 != curr_username }

            DispatchQueue.main.async {
                self.all_users = allUsers
                self.filtered_results = allUsers
            }
        } catch {
            print("🔥 Error fetching usernames: \(error.localizedDescription)")
        }
    }

    func filterResults(for query: String) {
        if query.isEmpty {
            filtered_results = all_users
        } else {
            filtered_results = all_users.filter {
                $0.lowercased().contains(query.lowercased())
            }
        }
    }
}

struct BuddiesAdd_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BuddiesAdd()
        }
    }
}
