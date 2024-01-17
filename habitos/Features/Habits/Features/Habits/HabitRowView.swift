//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by Víctor Alba on 9/11/23.
//

import SwiftUI

struct HabitRowView: View {
    
    let habit: Habit
    
    @State private var progress = 0.5
    var body: some View {
        HStack{
            VStack(alignment: .leading, content: {
                Text(habit.name)
                    .font(.title3)
                
                ProgressView(value: habit.process)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.cyan))
                    .lineLimit(1, reservesSpace: true)
                    .frame(minWidth: 1, idealWidth: 150, maxWidth: 200)

            })
            Spacer()
            VStack{
                Text("Fin")
                    .font(.title3)
                    .foregroundStyle(Color(.gray))
//                Text("\(habit.getFormatedDayDate())")
//                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    .font(.title)
//                    .foregroundStyle(Color(.cyan))
                
            }
            Spacer()
        }
    }
}

#Preview {
    HabitRowView(habit: .example)
}
