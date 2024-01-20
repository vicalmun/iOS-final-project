//
//  Coordinator.swift
//  HabitTracker
//
//  Created by Víctor Alba on 8/11/23.
//

import Foundation

class Coordinator: ObservableObject {
    
    private let habitsRepo: HabitsRepository
    private let datesRepo: DatesRepository = DatesRepository()

    init() {
        let habitsLocalService: HabitLocalService = HabitLocalImpl()
        
        habitsRepo = HabitsRepository(localService: habitsLocalService)
    }
    
    // MARK: - HabitsView
    func makeHabitMainView() -> HabitsMainView {
        HabitsMainView(viewModel: self.makeHabitsViewViewModel())
    }
    
    private func makeHabitsViewViewModel() -> HabitsViewModel {
        .init(habitsRepository: habitsRepo, datesRepository: datesRepo)
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
