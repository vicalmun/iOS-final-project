//
//  Habit.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//

import Foundation

class Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var startDate: Date
    var isCompleted: Bool
    var isFavourite: Bool
    var timesPerDay: Int
    var markedTimes: Int
    var completedDates: Set<DateComponents>
    var process: Double {
        if markedTimes == 0 {
            return 0.0
        }
        if markedTimes > timesPerDay {
            return 1.0
        }
        return Double(markedTimes) / Double(timesPerDay)
    }
    
    init(id: UUID, name: String, description: String, startDate: Date, timesPerDay: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.startDate = startDate
        self.isCompleted = false
        self.isFavourite = false
        self.timesPerDay = timesPerDay
        self.markedTimes = 0
        self.completedDates = []
    }
    
    static var example: Habit {
        .init(id: UUID(), name: "leer", description: "Leer 15 minutos al día", startDate: Date(timeIntervalSince1970: 1699637554958), timesPerDay: 2)
    }
}
