//
//  AppCard.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/16/26.
//

import SwiftUI

struct AppCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            content
        }
        .padding(20)
        .background(AppColors.card)
        .cornerRadius(26)
        .overlay(
            RoundedRectangle(cornerRadius: 26)
                .stroke(AppColors.border, lineWidth: 1)
        )
    }
}
