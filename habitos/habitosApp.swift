//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Víctor Alba on 8/11/23.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    let coord = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coord)
        }
    }
}
