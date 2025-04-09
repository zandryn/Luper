//
//  LoginAcc.swift
//  Luper
//
//  Created by Zandryn Epan on 4/7/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct User {
    var id: String
    var username: String
    var email: String
}

struct LoginAcc: View {
    @AppStorage("is_logged_in") private var is_logged_in = false
    @AppStorage("curr_username") private var curr_username = ""
    @State private var email: String = ""
    @State private var username: String = "" // will implement login w this later
    @State private var password: String = ""
    @State private var fetched_user: User?
    @State private var ia_message: String = ""
    @State private var show_alert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()

            TextField("email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
            
            SecureField("password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
            
            Button {
                guard !email.isEmpty, !password.isEmpty else {
                    ia_message = "Please fill in all fields."
                    show_alert = true
                    return
                }

                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if let error = error {
                        ia_message = error.localizedDescription
                        show_alert = true
                    } else if let user = result?.user {
                        let db = Firestore.firestore()
                        let docRef = db.collection("users").document(user.uid)

                        docRef.getDocument { document, error in
                            if let error = error {
                                ia_message = "Failed to fetch user data: \(error.localizedDescription)"
                                show_alert = true
                                return
                            }

                            if let data = document?.data(),
                               let username = data["username"] as? String,
                               let email = data["email"] as? String {
                                
                                self.fetched_user = User(id: user.uid, username: username, email: email)
                                self.curr_username = username
                                self.is_logged_in = true
                                ia_message = "Welcome back, \(username)!"
                                show_alert = true
                            } else {
                                ia_message = "User data is incomplete or missing."
                                show_alert = true
                            }
                        }
                    }
                }
            } label: {
                Text("Log In")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.purple)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(20)
            .padding()
            .alert(isPresented: $show_alert) {
                Alert(
                    title: Text("Login Status"),
                    message: Text(ia_message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct LoginAcc_Previews: PreviewProvider {
    static var previews: some View {
        LoginAcc()
    }
}
