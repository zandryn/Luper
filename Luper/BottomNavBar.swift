//
//  BottomNavBar.swift
//  Luper
//
//  Created by Zandryn Epan on 4/10/25.
//

import SwiftUI

struct BottomNavBar: View {
    @State private var selected_tab = 0

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selected_tab) {
                Home()
                    .tag(0)
                Logs()
                    .tag(1)
                Profile()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            HStack {
                tabItem(icon: "house.fill", label: "Home", tag: 0, color: .purple)
                tabItem(icon: "list.bullet.rectangle", label: "Logs", tag: 1, color: .indigo)
                tabItem(icon: "person.crop.circle", label: "Profile", tag: 2, color: .teal)
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
            .background(Color(.systemGray6))
        }
    }

    @ViewBuilder
    func tabItem(icon: String, label: String, tag: Int, color: Color) -> some View {
        Button(action: {
            selected_tab = tag
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(selected_tab == tag ? color : .gray)
                Text(label)
                    .font(.caption)
                    .foregroundColor(selected_tab == tag ? color : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
