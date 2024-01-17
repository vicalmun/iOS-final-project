//
//  HabitLocalService.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//

import Foundation

// la idea es que sea un protocolo para que cada implementación tenga los mismos métodos
protocol HabitLocalService {
    func getHabits() throws -> [Habit]
    
    // throws pq le pasa el error al repositorio
    func save(habits: [Habit]) throws
    
    // func localSaving (habit: Habit) esto debería hacelro el repo, que luego a su vez llame a save del servicio
    
    func editHabit(habit: Habit) throws
    
    func deleteHabit(habit: Habit) throws
}
