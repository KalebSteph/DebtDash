//
//  WelcomeView.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/10/26.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var debtStore: DebtStore
    var body: some View {
        VStack {
            Spacer()

            Text("Welcome to\nDebtDash")
                .font(.system(size: 36, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)

            Text("Take control of your debt\nand track your progress easily.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.top, 10)

            Spacer()

            NavigationLink(destination: DebtView()) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 55)
                    .background(Color.black)
                    .cornerRadius(16)
            }

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
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
            .environmentObject(DebtStore())
    }
}
