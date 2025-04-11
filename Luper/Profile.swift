//
//  Profile.swift
//  Luper
//
//  Created by Zandryn Epan on 4/10/25.
//

import SwiftUI

struct Profile: View {
    @State private var show_buddies = false
    @AppStorage("pfp_name") var pfp_name: String = "loopy"

    var body: some View {
        VStack(spacing: 20) {
            Text("👤 Profile")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("TEMP: This is your profile page.")
                .foregroundColor(.secondary)
            
            Image(pfp_name)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            Button(action: {
                show_buddies = true
            }) {
                HStack {
                    Image(systemName: "person.2.fill")
                        .font(.title2)
                    Text("View Buddies")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .cornerRadius(12)
                .shadow(radius: 5)
            }
            .padding(.horizontal)
            .sheet(isPresented: $show_buddies) {
                Buddies()
            }

            Spacer()
        }
        .padding()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
