//
//  DebtView.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/9/26.
//

import SwiftUI

struct DebtView: View {
    @EnvironmentObject var debtStore: DebtStore

    @State private var goalName: String = ""
    @State private var debtText: String = ""
    @State private var goToGoals = false

    var body: some View {
        VStack {
            Spacer()

            Text("Enter New\nDebt Goal")
                .font(.system(size: 34, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(AppColors.textPrimary)

            Spacer()

            AppCard {
                AppField(title: "Goal Name", placeholder: "Enter Goal", text: $goalName)

                AppField(
                    title: "Debt Amount",
                    placeholder: "Enter amount",
                    text: $debtText,
                    keyboardType: .decimalPad
                )

                PrimaryButton(title: "Save Goal") {
                    let cleanedText = debtText.replacingOccurrences(of: ",", with: "")
                    let trimmedName = goalName.trimmingCharacters(in: .whitespacesAndNewlines)

                    if let amount = Double(cleanedText), amount > 0, !trimmedName.isEmpty {
                        debtStore.addGoal(name: trimmedName, totalDebt: amount)
                        goalName = ""
                        debtText = ""
                        goToGoals = true
                    }
                }

                NavigationLink("", destination: GoalsView(), isActive: $goToGoals)
                    .hidden()
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        DebtView()
    }
    .environmentObject(DebtStore())
}
