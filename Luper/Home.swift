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

    @State private var show_notifs = false
    @State private var show_record = false

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    ZStack {
                        Text("Welcome, \(username)!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)

                        HStack {
                            Spacer()
                            Button(action: {
                                show_notifs = true
                            }) {
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.purple)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding(.top, 10)

                    Spacer()

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
                .frame(width: geo.size.width, height: geo.size.height)

                Button(action: {
                    show_record = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.purple)
                        .background(Color.white.opacity(0.01))
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .padding(.bottom, 24)
                        .padding(.trailing, 24)
                }
            }
            .fullScreenCover(isPresented: $show_notifs) {
                Notifs()
            }
            .sheet(isPresented: $show_record) {
                Record()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
