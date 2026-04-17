//
//  debtDashApp.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/16/26.
//

import SwiftUI

@main
struct debtDashApp: App {
    @StateObject private var debtStore = DebtStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
            .environmentObject(debtStore)
        }
    }
}
