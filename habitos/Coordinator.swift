//
//  Coordinator.swift
//  HabitTracker
//
//  Created by Víctor Alba on 8/11/23.
//

import Foundation

class Coordinator: ObservableObject {
    
    // ahora el max nivel de implemtenacion es el de VM (pq estoy mockeando todo) así que no necesito acceder a nada
    private let habitsRepo: HabitsRepository

    init() {
        
        // el servicio es la impl pq lo hereda, relax
        let habitsLocalService: HabitLocalService = HabitLocalImpl()
        
        habitsRepo = HabitsRepository(localService: habitsLocalService)
    }
    
    // 16/01/24 ya no, así que empiezo a meter servicios y esas cosas por aquí sin acordarme de nada xd
    
    
    // MARK: - HabitsView
    func makeHabitMainView() -> HabitsMainView {
        HabitsMainView(viewModel: self.makeHabitsViewViewModel())
    }
    
    private func makeHabitsViewViewModel() -> HabitsViewModel {
        .init(habitsRepository: habitsRepo)
    }
    
    // MARK: - HabitDetailView
    func makeCharacterDetailView(habit: Habit) -> HabitDetailView {
        .init(habit: habit)
    }
    
    func makeNewHabitView() -> NewHabitView {
        NewHabitView(habitsViewModel: self.makeHabitsViewViewModel())
    }
    
    func makeEditHabitView(habit: Habit) -> EditHabitView {
        EditHabitView(habit: habit, viewModel: self.makeHabitsViewViewModel())
    }
    
    // MARK: - LeaderBoardView
    func makeLeaderboardView() -> LeaderboardView {
        LeaderboardView()
    }
   
    
}
