//
//  CreateAcc.swift
//  Luper
//
//  Created by Zandryn Epan on 4/7/25.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore // used for usernames

struct CreateAcc: View {
    @AppStorage("is_logged_in") private var is_logged_in = false
    @AppStorage("curr_username") private var curr_username = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirm_password: String = ""
    @State private var show_alert = false
    @State private var ia_message: String = ""
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create An Account")
                .font(.title)
                .fontWeight(.bold)
            
            // User Inputs
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.purple, lineWidth: 2)
                }
                .padding(.horizontal)
            
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(15)
            
            
            SecureField("Password", text: $password)
                .textContentType(.newPassword)
                .submitLabel(.next)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
            
            SecureField("Confirm Password", text: $confirm_password)
                .textContentType(.newPassword)
                .submitLabel(.done)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
            
            
            Button(action: {
                let db = Firestore.firestore()

                // password validation
                guard !email.isEmpty, !password.isEmpty else {
                    ia_message = "Email and password are required."
                    show_alert = true
                    return
                }

                // check if password & confirmation are the same
                guard password == confirm_password else {
                    ia_message = "Passwords do not match."
                    show_alert = true
                    return
                }

                // check username uniqueness
                db.collection("users").whereField("username", isEqualTo: username).getDocuments { snapshot, error in
                    if let error = error {
                        ia_message = "Error checking username: \(error.localizedDescription)"
                        show_alert = true
                        return
                    }

                    if let snapshot = snapshot, !snapshot.isEmpty {
                        ia_message = "Username already taken."
                        show_alert = true
                        return
                    }

                    // create user
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        if let error = error {
                            ia_message = "Invalid credentials. Try again. \(error.localizedDescription)"
                            show_alert = true
                            return
                        }

                        if let user = result?.user {
                            db.collection("users").document(user.uid).setData([
                                "username": username,
                                "email": email
                            ]) { error in
                                if let error = error {
                                    ia_message = "Account created but failed to save user data: \(error.localizedDescription)"
                                } else {
                                    ia_message = "Account successfully created!"
                                    curr_username = username
                                    is_logged_in = true
                                }
                                show_alert = true
                            }
                        }
                    }
                }
            }) {
                Text("Create My Account")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .padding()
            .alert(isPresented: $show_alert) {
                Alert(title: Text("Signup Status"), message: Text(ia_message), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct CreateAcc_Previews: PreviewProvider {
    static var previews: some View {
    CreateAcc()
    }
}
