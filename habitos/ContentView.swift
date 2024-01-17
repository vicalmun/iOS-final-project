//
//  ContentView.swift
//  HabitTracker
//
//  Created by Víctor Alba on 8/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        
        TabView{
            coordinator.makeLeaderboardView()
                .tabItem {
                    Label("Inicio", systemImage: "drop.halffull" ).labelStyle(.iconOnly)
                }
            coordinator.makeHabitMainView()
                .tabItem {
                    Label("Mi sección", systemImage: "face.smiling")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
