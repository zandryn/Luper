//
//  LuperApp.swift
//  Luper
//
//  Created by Zandryn Epan on 4/7/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct LuperApp: App {
    // connect app delegate to firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("is_logged_in") private var is_logged_in = false
    @AppStorage("curr_username") private var curr_username = ""

    var body: some Scene {
        WindowGroup {
            if is_logged_in {
                BottomNavBar()
            } else {
                AuthRouterView()
            }
        }
    }
}
