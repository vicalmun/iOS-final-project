//
//  EditHabitView.swift
//  habitos
//
//  Created by Víctor Alba on 18/1/24.
//

import SwiftUI

struct EditHabitView: View {
    
    @State var habit: Habit
    @StateObject var viewModel: HabitsViewModel
    @EnvironmentObject var coordinator: Coordinator
    

    var body: some View {
        VStack {
            TextField("Name", text: $habit.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $habit.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            DatePicker("Start Date", selection: $habit.startDate, displayedComponents: .date)
                .padding()

            HStack {
                Text("Completed")
                Toggle(isOn: $habit.isCompleted) {
                    Text("Is Completed")
                }
            }
            .padding()

            HStack {
                Text("Favourite")
                Toggle(isOn: $habit.isFavourite) {
                    Text("Is Favourite")
                }
            }
            .padding()

            Stepper("Times Per Day: \(habit.timesPerDay)", value: $habit.timesPerDay, in: 1...10)
                .padding()

            Stepper("Marked Times: \(habit.markedTimes)", value: $habit.markedTimes, in: 0...habit.timesPerDay)
                .padding()
            
            Button("Guardar") {
                viewModel.editHabit(habit: habit)
                
            }
        }
    }
}

//#Preview {
//    EditHabitView(habit: .example)
//}
