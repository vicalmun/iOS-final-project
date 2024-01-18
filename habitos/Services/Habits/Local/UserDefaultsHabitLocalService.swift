//
//  HabitLocalImpl.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//
// Esta implementación de UserDefaults sí me la he copiado del curso, concretamente del proyecto de Rick Y Morty de Javi Torné

import Foundation

struct HabitLocalImpl: HabitLocalService {
    
    private let habitsUDKey = "habitos"
    
    func save (habits: [Habit]) throws {
        let data = try JSONEncoder().encode(habits)
        UserDefaults.standard.set(data, forKey: habitsUDKey)
    }
    
    func getHabits() throws -> [Habit] {
        guard let data = UserDefaults.standard.data(forKey: habitsUDKey) else {
            return []
        }
        return try JSONDecoder().decode([Habit].self, from: data)
    }

//    // TODO: rehacer esta funcion, porque debería hacer throws
//    func localSaving (habit: Habit) {
//        do {
//            var habits = try getHabits()
//            habits.append(habit)
//            try save(habits: habits)
//        } catch {
//            print("Ha petao")
//        }
//        
//    }   // todo esto debe ir al repo no en la implementación

    func editHabit(habit: Habit) throws {
        do {
            var habits = try getHabits()
            
            if let index = habits.firstIndex(where: { $0.id == habit.id }) {
                habits[index] = habit
                try save(habits: habits)
            } else {}
        } catch {
            throw error
        }
    }

    func deleteHabit(habit: Habit) throws {
        do {
            var habits = try getHabits()
            habits.removeAll { $0.id == habit.id }
            try save(habits: habits)
        } catch {
        throw error
        }
    }
    
}
