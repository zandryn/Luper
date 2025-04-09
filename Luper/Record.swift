//
//  Record.swift
//  Luper
//
//  Created by Zandryn Epan on 4/9/25.
//

import SwiftUI

struct Record: View {
    @State private var search_db = ""
    @StateObject private var tvdb = API_TVDB()
    @State private var rating = 0
    @State private var review = ""
    @State private var with_who = ""
    
    @State private var source = "Netflix"
    let sources = ["Netflix", "Hulu", "Disney+", "Max", "Amazon Prime", "Other"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Search TV Show or Movie")) {
                    TextField("Start typing...", text: $search_db)
                        .autocapitalization(.none)
                    
                    if !tvdb.results.isEmpty {
                        ForEach(tvdb.results, id: \.self) { title in
                            Button(action: {
                                search_db = title
                                tvdb.results = []
                            }) {
                                Text(title)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
                Section(header: Text("Rating")) {
                    Stepper(value: $rating, in: 0...5) {
                        Text("⭐️ \(rating) stars")
                    }
                }
                
                Section(header: Text("Thoughts / Review")) {
                    TextEditor(text: $review)
                        .frame(height: 100)
                }
                
                Section(header: Text("Where did you watch it?")) {
                    Picker("Select Source", selection: $source) {
                        ForEach(sources, id: \.self) { platform in
                            Text(platform)
                        }
                    }
                }
                
                // basic for now - will replace w multiselect and pull friend names from firestore
                Section(header: Text("Watched with?")) {
                    TextField("Tag or add friends (optional)", text: $with_who)
                        .autocapitalization(.none)
                }
                
                Section {
                    Button("Save Entry") {
                        // placeholder for Mongo save later
                        print("✨ I clicky the button and it works!")
                    }
                    .foregroundColor(.purple)
                }
            }
            .navigationTitle("New Log")
        
            .onAppear {
                tvdb.authenticate { success in
                    if success {
                        print("💖 TVDB Auth SLAYYYED")
                    } else {
                        print("👺 TVDB Auth FLOPPED")
                    }
                }
            }
            .onChange(of: search_db) { _, newValue in
                guard !newValue.isEmpty else { return }
                tvdb.search(query: newValue)
            }
        }
    }
}

struct Record_Previews: PreviewProvider {
    static var previews: some View {
        Record()
    }
}
