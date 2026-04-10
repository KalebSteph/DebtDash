//
//  GoalsView.swift
//  debtDash
//
//  Created by Kaleb Stephens on 3/27/26.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var debtStore: DebtStore
    @State private var paymentText: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 60)

            Text("Goals")
                .font(.system(size: 34, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 30)

            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("$\(debtStore.totalDebt, specifier: "%.2f") - Debt Goal")
                        .font(.headline)

                    ProgressView(value: debtStore.progress)
                        .progressViewStyle(.linear)
                        .scaleEffect(x: 1, y: 3, anchor: .center)
                        .tint(.gray)
                        .padding(.trailing, 10)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Paid: $\(debtStore.amountPaid, specifier: "%.2f")")
                        Text("Remaining: $\(debtStore.remainingDebt, specifier: "%.2f")")
                    }
                    .font(.subheadline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Add Money Toward Goal")
                            .font(.headline)

                        TextField("Enter payment amount", text: $paymentText)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )

                        Button {
                            let cleanedText = paymentText.replacingOccurrences(of: ",", with: "")
                            if let amount = Double(cleanedText), amount > 0 {
                                debtStore.addPayment(amount)
                                paymentText = ""
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
                    .padding(.top, 15)
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 20)
            }
            .frame(maxHeight: .infinity)

            HStack {
                Circle()
                    .fill(Color.gray.opacity(0.35))
                    .frame(width: 48, height: 48)

                Spacer()

                Text("Help")
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    let store = DebtStore()
    store.setDebt(50000)
    store.addPayment(12000)

    return NavigationStack {
        GoalsView()
            .environmentObject(store)
    }
}
