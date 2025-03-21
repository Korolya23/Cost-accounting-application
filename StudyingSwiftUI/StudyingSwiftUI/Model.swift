//
//  Model.swift
//  StudyingSwiftUI
//
//  Created by Artem on 10.03.25.
//

import Foundation

struct Model: Identifiable, Codable {
    var id = UUID()
    let amount: Double
    let category: String
    let date: Date
}
