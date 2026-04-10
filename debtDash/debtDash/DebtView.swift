//
//  DebtView.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/9/26.
//

import SwiftUI

struct DebtView: View {
    @EnvironmentObject var debtStore: DebtStore

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

            VStack(spacing: 12) {
                TextField("Enter Debt Here", text: $debtText)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .padding(.horizontal, 30)

                Rectangle()
                    .fill(Color.gray.opacity(0.7))
                    .frame(width: 240, height: 1)
            }

            Button {
                let cleanedText = debtText.replacingOccurrences(of: ",", with: "")
                if let amount = Double(cleanedText), amount > 0 {
                    debtStore.setDebt(amount)
                    goToGoals = true
                }
            } label: {
                Text("Go To Goals")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 180, height: 50)
                    .background(Color.black)
                    .cornerRadius(14)
            }
            .padding(.top, 30)

            Spacer()

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
        .navigationDestination(isPresented: $goToGoals) {
            GoalsView()
                .environmentObject(debtStore)
        }
    }
}

#Preview {
    NavigationStack {
        DebtView()
            .environmentObject(DebtStore())
    }
}
