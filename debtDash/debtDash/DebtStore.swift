//
//  DebtStore.swift
//  debtDash
//
//  Created by Kaleb Stephens on 3/27/26.
//

import Foundation

final class DebtStore: ObservableObject {
    @Published var totalDebt: Double = 0
    @Published var amountPaid: Double = 0

    var remainingDebt: Double {
        max(totalDebt - amountPaid, 0)
    }

    var progress: Double {
        guard totalDebt > 0 else { return 0 }
        return min(amountPaid / totalDebt, 1.0)
    }

    func setDebt(_ amount: Double) {
        totalDebt = amount
        amountPaid = 0
    }

    func addPayment(_ amount: Double) {
        guard amount > 0 else { return }
        amountPaid = min(amountPaid + amount, totalDebt)
    }
}
