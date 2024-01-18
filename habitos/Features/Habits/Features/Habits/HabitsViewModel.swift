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
    private let datesRepository: DatesRepository

    // variable que representa el array de hábitos (se inicializa vacío)
    @Published var habits = [Habit]()
    
    @Published var showErrorMessage = false
    
    @Published var lastResetDate: DateComponents!
    
    init(habitsRepository: HabitsRepository, datesRepository: DatesRepository) {
        self.habitsRepository = habitsRepository
        self.datesRepository = datesRepository
    }
    
    // MARK: CRUD de hábitos + extra
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
    
    func editHabit(habit: Habit) {
        do {
            try habitsRepository.editHabit(habit: habit)
        } catch {
            showErrorMessage = true
        }
    }
    
    func markCompletedOneTimeMore (habit: Habit) async{
        do {
            try habitsRepository.markAsCompletedOneTime(habit: habit)
        } catch {
            showErrorMessage = true
        }
        await getHabits()
    }
    
    // MARK: Variable global para reinicar las fechas
    func makeDateComponents (date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day], from: date)
    }

    func checkAndResetMarkedTimes() {
        do {
            let currentDate = Date.now
            // si no es la misma fecha: (ergo ha cambiado)
            if !Calendar.current.isDate(currentDate, inSameDayAs: try datesRepository.getLastResetDate()) {
                for i in 0..<habits.count {
                    habits[i].markedTimes = 0
                }
                try datesRepository.saveLastResetDate(date: currentDate)
                try habitsRepository.save(habits: habits) // Guarda los cambios en UserDefaults
            }
        
        
            lastResetDate = makeDateComponents(date: try datesRepository.getLastResetDate())
        } catch{
            showErrorMessage = true
        }
        }
}
