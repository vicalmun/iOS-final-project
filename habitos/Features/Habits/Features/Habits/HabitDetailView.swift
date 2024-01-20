//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Víctor Alba on 9/11/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var habit: Habit

    var body: some View {
        VStack(alignment: .center , content: {
            createDetailView(habit: habit)
            Divider()
            // TODO: esto debería ir al controller
            UICalendarViewRepresentable(completedDates: habit.completedDates)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                .padding(.bottom, 120)
            Spacer()
        }).padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: coordinator.makeEditHabitView(habit: habit)) {
                                    Text("Editar")
                                }
                            }
                }
       
    }
    
    
    func createDetailView(habit: Habit) -> some View {
        VStack{
            Text(habit.name).font(.largeTitle).padding().foregroundStyle(Color(.cyan))
            Text(habit.description).font(.title2).padding()
        }.frame(minWidth: 800)
    }
    
    func createEditableView(habit: Habit) -> some View {
        VStack{
            // TODO: hacer este binding bien
            TextEditor(text: Binding.constant(habit.name))
            Divider()
            TextEditor(text: Binding.constant(habit.description))
        }
    }
}

#Preview {
    HabitDetailView(habit: .example)
}
