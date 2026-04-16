//
//  DebtGoal.swift
//  debtDash
//
//  Created by Kaleb Stephens on 4/14/26.
//

import Foundation

struct DebtGoal: Identifiable, Codable {
    let id: UUID
    var name: String
    var totalDebt: Double
    var amountPaid: Double

    init(id: UUID = UUID(), name: String, totalDebt: Double, amountPaid: Double = 0) {
        self.id = id
        self.name = name
        self.totalDebt = totalDebt
        self.amountPaid = amountPaid
    }

    var remainingDebt: Double {
        max(totalDebt - amountPaid, 0)
    }

    var progress: Double {
        guard totalDebt > 0 else { return 0 }
        return min(amountPaid / totalDebt, 1)
    }
}
