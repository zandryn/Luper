//
//  Logs.swift
//  Luper
//
//  Created by Zandryn Epan on 4/10/25.
//

// Logs.swift
import SwiftUI

struct Logs: View {
    var body: some View {
        VStack {
            Text("📚 Your Logs")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("TEMP: Here you'll see all your entries.")
                .foregroundColor(.black)
        }
        .padding()
    }
}

struct Logs_Previews: PreviewProvider {
    static var previews: some View {
        Logs()
    }
}
