//
//  Habit.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//

import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var process: Double
    var startDate: Date
    var isCompleted: Bool = false
    var isFavourite: Bool = false
    
    static var example: Habit {
        .init(id: UUID(), name: "leer", description: "Leer 15 minutos al día", process: 0.35, startDate: Date(timeIntervalSince1970: 1699637554958))
    }
}
