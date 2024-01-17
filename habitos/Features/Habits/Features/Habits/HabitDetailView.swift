//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Víctor Alba on 9/11/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    let habit: Habit
    
    // MARK: esto lo borro, es para el set de fechas
    let datesComponents: Set<DateComponents> = [
        DateComponents(year: 2024, month: 1, day: 16),
        DateComponents(year: 2024, month: 1, day: 15),
        DateComponents(year: 2024, month: 1, day: 14),
        DateComponents(year: 2024, month: 1, day: 12)
    ]


// MARK: set de fehcas hasta aqui
    
    
    var body: some View {
        VStack(alignment: .center , content: {
            createDetailView(habit: habit)
            Divider()
            // TODO: esto debería ir al controller
            UICalendarViewRepresentable(completedDates: datesComponents)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                .padding(.bottom, 120)
            Spacer()
        }).padding()
       
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
