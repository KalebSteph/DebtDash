//
//  WelcomeView.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/16/26.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Welcome to\nDebtDash")
                .font(.system(size: 36, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.textPrimary)

            Text("Take control of your debt\nand track your progress easily.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.textSecondary)
                .padding(.top, 10)

            Spacer()

            NavigationLink(destination: DebtView()) {
                Text("Get Started")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 220, height: 54)
                    .background(AppColors.pink)
                    .cornerRadius(16)
            }
            .buttonStyle(.plain)

            Spacer()
        }
        .padding(.horizontal, 24)
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
    .environmentObject(DebtStore())
}
