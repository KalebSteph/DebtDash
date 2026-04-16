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
        VStack(alignment: .leading) {
            Spacer().frame(height: 60)

            Text("Goals")
                .font(.system(size: 34, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)

            if debtStore.goals.isEmpty {
                Spacer()

                Text("No goals saved yet.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
            } else {
                List {
                    ForEach(debtStore.goals) { goal in
                        VStack(alignment: .leading, spacing: 14) {
                            Text(goal.name)
                                .font(.title3)
                                .fontWeight(.bold)

                            Text("$\(goal.totalDebt, specifier: "%.2f") - Debt Goal")
                                .font(.headline)

                            ProgressView(value: goal.progress)
                                .progressViewStyle(.linear)
                                .scaleEffect(x: 1, y: 2.5, anchor: .center)
                                .tint(.gray)

                            Text("Paid: $\(goal.amountPaid, specifier: "%.2f")")
                                .font(.subheadline)

                            Text("Remaining: $\(goal.remainingDebt, specifier: "%.2f")")
                                .font(.subheadline)

                            TextField("Enter payment amount", text: Binding(
                                get: { paymentInputs[goal.id] ?? "" },
                                set: { paymentInputs[goal.id] = $0 }
                            ))
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )

                            Button {
                                let text = paymentInputs[goal.id] ?? ""
                                let cleanedText = text.replacingOccurrences(of: ",", with: "")

                                if let amount = Double(cleanedText), amount > 0 {
                                    debtStore.addPayment(to: goal, amount: amount)
                                    paymentInputs[goal.id] = ""
                                }
                            } label: {
                                Text("Add Payment")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.black)
                                    .cornerRadius(14)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                    .onDelete(perform: debtStore.deleteGoal)
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemGray6))
            }
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    let store = DebtStore()
    store.goals = [
        DebtGoal(name: "Car Loan", totalDebt: 12000, amountPaid: 3000),
        DebtGoal(name: "Credit Card", totalDebt: 5000, amountPaid: 1500)
    ]

    return NavigationStack {
        GoalsView()
    }
    .environmentObject(store)
}
