//
//  HabitLocalService.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//

import Foundation

protocol HabitLocalService {
    func getHabits() throws -> [Habit]
    
    func save(habits: [Habit]) throws
        
    func editHabit(habit: Habit) throws
    
    func deleteHabit(habit: Habit) throws
}
