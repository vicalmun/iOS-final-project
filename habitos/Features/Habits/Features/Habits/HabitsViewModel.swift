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
//    func createHabit (name: String, desc: String, times: Int){
//        let habitAux = Habit(id: UUID(), name: name, description: desc, startDate: Date.now, isCompleted: false, isFavourite: false, timesPerDay: times)
//        habits.append(habitAux)
//    }
    
    
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
            showErrorMessage = true
        }
        await getHabits()
    }
    
    @MainActor
    func getHabits() async {
        do {
            habits = try await habitsRepository.getHabits()
        } catch {
            showErrorMessage = true
        }
    }
    
    
    
    
    // TODO: editHabit tiene que eliminar el hábito de la lista y añadir el nuevo en su lugar -> es literal lo que hace el edit habit del repo -> que es lo que hace el edit de la implementacion (well)
    func editHabit(habit: Habit) {
        do {
            try habitsRepository.editHabit(habit: habit)
        } catch {
            showErrorMessage = true
        }
    }
    
    
    // TODO: markAsCompleted -> edita el habito para cambiar el valor de isCompleted -> me la llevo al repo
    func markCompletedOneTimeMore (habit: Habit) async{
        do {
            try habitsRepository.markAsCompletedOneTime(habit: habit)
        } catch {
            showErrorMessage = true
        }
        await getHabits()
    }
    
}
