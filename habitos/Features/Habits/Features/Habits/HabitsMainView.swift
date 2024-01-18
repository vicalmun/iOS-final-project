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
                        // TODO: meter swipeActios a los hábitos para marcar como completado de izq-drch, editar y eliminar de drch-izq
                        // So, cambiar la vista de detalle
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
//                                Button{
//                                } label: {
//                                    if !habit.isFavourite {
//                                        Label("Complete", systemImage: "star.fill").tint(.yellow)
//                                    } else {
//                                        Label("Complete", systemImage: "star.slash")
//                                    }
//                                    
//                                }
                            }
                              .swipeActions(edge: .trailing, allowsFullSwipe: false){
                                  Button(role: .destructive) {
                                      viewModel.delete(habit: habit)
                                  } label: {
                                      Label("Delete", systemImage: "trash")
                                  }
//                                  Button{
//                                      //
//                                  } label: {
//                                      Image(systemName: "pencil")
//                                  }.tint(.orange)
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
    
    // TODO: mover esta funcion al coordinator
    // no, pq creo que tendría que pasarsela a la vista para usarla
    // o no por eso de que sea un environmentobject
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
