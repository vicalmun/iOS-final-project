//
//  HabitsRepository.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//

import Foundation

// esta clase descarga de lógica al VM
struct HabitsRepository {
    
    // Usa los servicios
    private let localService: HabitLocalService
    
    // que se le pasa como parámetro
    // TODO: OJO que luego cuando se construya hay que pasarle la implementacion de servicio local que queremos
    init(localService: HabitLocalService) {
        self.localService = localService
    }
    
    func save (habits: [Habit]) throws {
        try localService.save(habits: habits)
    }

    // para poder usar los métodos de este, aquí solo hacemos un puente entre el serivio y el repo (o quien llame al repo = VM)
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
            throw error
        }
    }
    
}
