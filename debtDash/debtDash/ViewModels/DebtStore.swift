//
//  DebtStore.swift
//  debtDash
//
//  Created by Kaleb Stephens on 3/27/26.
//

import SwiftUI

class DebtStore: ObservableObject {
    @Published var goals: [DebtGoal] = [] {
        didSet {
            saveGoals()
        }
    }

    private let saveKey = "saved_debt_goals"

    init() {
        loadGoals()
    }

    func addGoal(name: String, totalDebt: Double) {
        let newGoal = DebtGoal(name: name, totalDebt: totalDebt)
        goals.append(newGoal)
    }

    func addPayment(to goal: DebtGoal, amount: Double) {
        guard let index = goals.firstIndex(where: { $0.id == goal.id }) else { return }

        goals[index].amountPaid += amount

        if goals[index].amountPaid > goals[index].totalDebt {
            goals[index].amountPaid = goals[index].totalDebt
        }
    }

    func deleteGoal(_ goal: DebtGoal) {
        goals.removeAll { $0.id == goal.id }
    }

    func deleteGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
    }
    
    func resetGoals() {
        goals = []
        UserDefaults.standard.removeObject(forKey: saveKey)
    }

    private func saveGoals() {
        do {
            let data = try JSONEncoder().encode(goals)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Failed to save goals: \(error)")
        }
    }

    private func loadGoals() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return }

        do {
            goals = try JSONDecoder().decode([DebtGoal].self, from: data)
        } catch {
            print("Failed to load goals: \(error)")
        }
    }
}
