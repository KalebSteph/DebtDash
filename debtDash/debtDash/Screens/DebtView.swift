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

            Text("Enter \nDebt Here")
                .font(.system(size: 34, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)

            Spacer()

            VStack(spacing: 16) {
                TextField("Goal Name", text: $goalName)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .padding(.horizontal, 30)

                Rectangle()
                    .fill(Color.gray.opacity(0.7))
                    .frame(width: 240, height: 1)

                TextField("Debt Amount", text: $debtText)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .padding(.horizontal, 30)

                Rectangle()
                    .fill(Color.gray.opacity(0.7))
                    .frame(width: 240, height: 1)

                Button {
                    let cleanedText = debtText.replacingOccurrences(of: ",", with: "")
                    if let amount = Double(cleanedText),
                       amount > 0,
                       !goalName.trimmingCharacters(in: .whitespaces).isEmpty {
                        debtStore.addGoal(name: goalName, totalDebt: amount)
                        goalName = ""
                        debtText = ""
                        goToGoals = true
                    }
                } label: {
                    Text("Save Goal")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 55)
                        .background(Color.black)
                        .cornerRadius(16)
                }
                .padding(.top, 20)

                NavigationLink("", destination: GoalsView(), isActive: $goToGoals)
                    .hidden()
            }

            Spacer()
        }
        .background(Color(.systemGray6))
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        DebtView()
    }
    .environmentObject(DebtStore())
}
