//
//  HabitsMainView.swift
//  HabitTracker
//
//  Created by Víctor Alba on 8/11/23.
//

import SwiftUI

struct HabitsMainView: View {
    
    @StateObject var viewModel: HabitsViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var showNewHabitView = false
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(viewModel.habits){ habit in
                        createHabitRow(habit: habit)
                            .swipeActions(edge: .leading,
                                          allowsFullSwipe: true){
                                Button{
                                    Task {
                                        await viewModel.markCompletedOneTimeMore(habit: habit)
                                    }
                                } label: {
                                    Image(systemName: "checkmark")
                                }.tint(.cyan)
                            }
                              .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                  Button(role: .destructive) {
                                      viewModel.delete(habit: habit)
                                  } label: {
                                      Label("Delete", systemImage: "trash")
                                  }
                              }
                    }
                }.task {
                    await viewModel.getHabits()
                }
                .navigationTitle("Mis hábitos")
                .toolbar {
                    ToolbarItem {
                        Button("Añadir", systemImage: "plus") {
                            showNewHabitView = true
                        }
                    }
                }
                .sheet(isPresented: $showNewHabitView) {
                    coordinator.makeNewHabitView()
                }.refreshable {
                    await viewModel.getHabits()
                }.alert(isPresented: $viewModel.showErrorMessage) {
                    Alert(title: Text("Ups, ha ocurido un error"), message: Text("Algo no ha salido como esperábamos :("), dismissButton: .cancel())
                }
            }
        }
    }
    
    func createHabitRow(habit: Habit) -> some View {
        NavigationLink {
            HabitDetailView(habit: habit)
        } label: {
            HabitRowView(habit: habit)
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeHabitMainView()
        .environmentObject(coordinator)
}
