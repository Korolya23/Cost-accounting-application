//
//  ContentViewModel.swift
//  StudyingSwiftUI
//
//  Created by Artem on 8.03.25.
//

import SwiftUI

@Observable
class ViewModel {
    var expences: [Model] = [] {
        didSet {
            saveExpences()
        }
    }
    var newAmount: String = ""
    var selectCategory: String = "Food"
    
    let categories = ["Food", "Clothing", "Housing"]
    
    let expencesKey = "expences"
    
    init () {
        loadExpences()
    }

    func addExpence() {
        guard let amount = Double(newAmount), amount > 0 else { return }
        let expense = Model(amount: amount, category: selectCategory, date: Date())
        expences.append(expense)
        newAmount = ""
    }
    
    func removeExpence(at index: IndexSet) {
        expences.remove(atOffsets: index)
    }
    
    func totalAmount() -> Double {
        expences.reduce(0) { $0 + $1.amount }
    }
    
    var totalAmoutByCategory: [String: Double] {
        var result: [String: Double] = [:]
        for expence in expences {
            result[expence.category, default: 0] += expence.amount
        }
        return result
    }
    
    func saveExpences() {
        let encode = try? JSONEncoder().encode(expences)
        UserDefaults.standard.set(encode, forKey: expencesKey)
    }
    
    func loadExpences() {
        if let data = UserDefaults.standard.data(forKey: expencesKey),
           let decode = try? JSONDecoder().decode([Model].self, from: data) {
            expences = decode
        }
    }
}

