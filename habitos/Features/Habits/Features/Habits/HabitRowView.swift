//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by Víctor Alba on 9/11/23.
//

import SwiftUI

struct HabitRowView: View {
    
    let habit: Habit
        
    var body: some View {
        HStack{
            VStack(alignment: .leading, content: {
                Text(habit.name)
                    .font(.title3)
                
                ProgressView(value: habit.process)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.cyan))
                    .lineLimit(1, reservesSpace: true)
                    .frame(minWidth: 1, idealWidth: 125, maxWidth: 150)

            })
            Spacer()
            VStack{
                Text("Hoy")
                    .font(.title3)
                    .foregroundStyle(Color(.gray))
                Text("\(habit.markedTimes)/\(habit.timesPerDay)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .foregroundStyle(Color(.cyan))
                
            }
            Spacer()
        }
    }
}

#Preview {
    HabitRowView(habit: .example)
}
