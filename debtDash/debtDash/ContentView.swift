//
//  ContentView.swift
//  debtDash
//
//  Created by Kaleb Stephens on 3/26/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var debtStore = DebtStore()

    var body: some View {
        NavigationStack {
            DebtView()
                .environmentObject(debtStore)
        }
    }
}

#Preview {
    ContentView()
}
