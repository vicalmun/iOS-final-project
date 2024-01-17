//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Víctor Alba on 9/11/23.
//
// El VM lo único que hace es proveerle datos a la vista


import Foundation

class HabitsViewModel: ObservableObject {
    // VM es quien provee datos a la vista
    
    private let habitsRepository: HabitsRepository

    // variable que representa el array de hábitos (se inicializa vacío)
    @Published var habits = [Habit]()
    
    @Published var showErrorMessage = false
    
    
    init(habitsRepository: HabitsRepository) {
        self.habitsRepository = habitsRepository
    }
        
    // no sé si va aquí, peeero
    func createHabit (name: String, desc: String){
        let habitAux = Habit(id: UUID(), name: name, description: desc, process: 0, startDate: Date.now, isCompleted: false, isFavourite: false)
        habits.append(habitAux)
    }
    
    
    func delete (habit: Habit){
        do {
            try habitsRepository.deleteHabit(habit: habit)
        } catch {
            
        }
    }
    
    func addHabitToList (habit: Habit) async {
        do {
            try await habitsRepository.addHabit(habit: habit)
        } catch {
            
        }
    }
    
    @MainActor
    func getHabits() async {
        do {
            habits = try await habitsRepository.getHabits()
        } catch {
            showErrorMessage = true
        }
    }
    
    
    // TODO: editHabit tiene que eliminar el hábito de la lista y añadir el nuevo en su lugar
    
    
    // TODO: markAsCompleted -> edita el habito para cambiar el valor de isCompleted
    
}
