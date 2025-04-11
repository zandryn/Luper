//
//  Notifs.swift
//  Luper
//
//  Created by Zandryn Epan on 4/10/25.
//

// Notifs.swift
import SwiftUI

struct Notifs: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Button("Go Back"){
                print("Back to Home Screen🏠")
                dismiss()
            }
        }
        Text("🔔 Notifications will show here.")
            .font(.title)
            .padding()
    }
}

struct Notifs_Previews: PreviewProvider {
    static var previews: some View {
        Notifs()
    }
}
