//
//  GoalsView.swift
//  debtDash
//
//  Created by Kaleb Stephens on 3/27/26.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var debtStore: DebtStore
    @State private var paymentInputs: [UUID: String] = [:]

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("Goals")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.top, 20)

                    if debtStore.goals.isEmpty {
                        AppCard {
                            VStack(spacing: 16) {
                                Text("No goals saved yet.")
                                    .font(.headline)
                                    .foregroundColor(AppColors.textPrimary)

                                Text("Add a goal to start tracking your progress.")
                                    .foregroundColor(AppColors.textSecondary)
                                    .multilineTextAlignment(.center)

                                NavigationLink(destination: DebtView()) {
                                    Text("Add Goal")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(AppColors.pink)
                                        .cornerRadius(14)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 24)
                    } else {
                        ForEach(debtStore.goals) { goal in
                            AppCard {
                                Text(goal.name)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(AppColors.purple)

                                Text("Remaining Balance")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(AppColors.textMuted)
                                    .textCase(.uppercase)

                                Text("$\(goal.remainingDebt, specifier: "%.2f")")
                                    .font(.system(size: 42, weight: .bold))
                                    .foregroundColor(AppColors.textPrimary)

                                GoalProgressBar(progress: goal.progress)

                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("$\(goal.amountPaid, specifier: "%.2f") Paid")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(AppColors.cyan)

                                        Text("Goal: $\(goal.totalDebt, specifier: "%.2f")")
                                            .font(.system(size: 13))
                                            .foregroundColor(AppColors.textSecondary)
                                    }

                                    Spacer()
                                }

                                AppField(
                                    title: "Enter Payment",
                                    placeholder: "500",
                                    text: Binding(
                                        get: { paymentInputs[goal.id] ?? "" },
                                        set: { paymentInputs[goal.id] = $0 }
                                    ),
                                    keyboardType: .decimalPad
                                )

                                PrimaryButton(title: "Add Payment") {
                                    let text = paymentInputs[goal.id] ?? ""
                                    let cleanedText = text.replacingOccurrences(of: ",", with: "")

                                    if let amount = Double(cleanedText), amount > 0 {
                                        debtStore.addPayment(to: goal, amount: amount)
                                        paymentInputs[goal.id] = ""
                                    }
                                }

                                Button(role: .destructive) {
                                    debtStore.deleteGoal(goal)
                                } label: {
                                    Text("Delete")
                                        .font(.system(size: 14, weight: .semibold))
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.top, 4)
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                }
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        GoalsView()
    }
    .environmentObject(DebtStore())
}
