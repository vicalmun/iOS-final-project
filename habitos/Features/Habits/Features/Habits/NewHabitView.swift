//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Víctor Alba on 13/11/23.
//

import SwiftUI

struct NewHabitView: View {
    
    @State private var name = ""
    @State private var description = ""
    @State private var timesPerDay: Int = 1
    @State private var selectedCategory = 1
    @Environment(\.dismiss) var dismiss
    
//    @StateObject private var habitsViewModel: HabitsViewModel
//
//    init(habitsViewModel: HabitsViewModel) {
//        _habitsViewModel = StateObject(wrappedValue: habitsViewModel)
//    }
    @ObservedObject private var habitsViewModel: HabitsViewModel

    init(habitsViewModel: HabitsViewModel) {
        self.habitsViewModel = habitsViewModel
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Nombre", text: $name)
                    TextField("Descripción", text: $description)
                    Stepper("Veces al día: \(timesPerDay)", value: $timesPerDay, in: 1...10)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button("Guardar") {
                            let habit = Habit(id: UUID(), name: name, description: description, startDate: Date.now, timesPerDay: timesPerDay)
                            
                            Task {
                                await habitsViewModel.addHabitToList(habit: habit)
                            }
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Nuevo hábito")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
            }
        }
    }
}


//#Preview {
//    NewHabitView( localService: HabitLocalImpl())
//}
