//
//  HabitsRepository.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//

import Foundation

struct HabitsRepository {
    
    private let localService: HabitLocalService
    
    init(localService: HabitLocalService) {
        self.localService = localService
    }
    
    func save (habits: [Habit]) throws {
        try localService.save(habits: habits)
    }

    func getHabits() async throws -> [Habit] {
        return try localService.getHabits()
    }
    
    func editHabit(habit: Habit) throws {
        try localService.editHabit(habit: habit)
    }
    
    func deleteHabit(habit: Habit) throws {
        try localService.deleteHabit(habit: habit)
    }
    
    func addHabit (habit: Habit) async throws {
        do {
            var habits = try await getHabits()
            habits.append(habit)
            try save(habits: habits)
        }
        catch {
            print("ha petado aqui")
            throw error
        }
    }
    
    func markAsCompletedOneTime (habit: Habit) throws {
        do {
            habit.markedTimes += 1
            
            if habit.markedTimes >= habit.timesPerDay {
                try addTodayDateToCalendarWhenHabitIsCompleted(habit: habit)
            }
            try editHabit(habit: habit)
        } catch {
            throw error
        }
    }
    
    func addTodayDateToCalendarWhenHabitIsCompleted (habit: Habit) throws {
        do {
            let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
            
            if !habit.completedDates.contains(today){
                habit.completedDates.insert(today)
            }
            
            try editHabit(habit: habit)
        } catch {
            throw error
        }
    }
    
}
