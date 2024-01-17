//
//  UICalendarViewRepresentable.swift
//  HabitTracker
//
//  Created by Víctor Alba on 10/11/23.
//
//
//import SwiftUI
//import UIKit
//
//struct UICalendarViewRepresentable: UIViewRepresentable {
//
//    var completedDates: Set<DateComponents>
//    var datesDataBase: MyEventDatabase
//
//
//    init(completedDates: Set<DateComponents>) {
//        self.completedDates = completedDates
//        self.datesDataBase = MyEventDatabase(completedDates: completedDates)
//    }
//
//    func makeUIView(context: Context) -> UICalendarView {
//        let calendarView = UICalendarView()
//        calendarView.delegate = datesDataBase
//        return calendarView
//    }
//
//    func updateUIView(_ uiView: UICalendarView, context: Context) {
//        // Actualiza la vista de UIKit aquí
//        datesDataBase.updateCompletedDates(completedDates)
//        uiView.setNeedsDisplay()
//    }
//}
//
//// MARK: Delegado del calendario
//class MyEventDatabase: NSObject, UICalendarViewDelegate {
//
//    var completedDates: Set<DateComponents> // Conjunto de fechas completadas
//
//    init(completedDates: Set<DateComponents>) {
//        self.completedDates = completedDates
//    }
//
//    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//        if completedDates.contains(dateComponents) {
//            // Aquí decides qué tipo de decoración usar. Por ejemplo, un círculo.
//            return UICalendarView.Decoration.default(color: .red, size: .small)
//        }
//        return nil
//    }
//
//    // actualiza la lista que maneja esta clase con sus propios valores
//    func updateCompletedDates(_ newDates: Set<DateComponents>) {
//            completedDates = newDates
//        }
//}
//


import SwiftUI
import UIKit

struct UICalendarViewRepresentable: UIViewRepresentable {
    
    var completedDates: Set<DateComponents>
    var datesDataBase: MyEventDatabase

    init(completedDates: Set<DateComponents>) {
        self.completedDates = completedDates
        self.datesDataBase = MyEventDatabase(completedDates: completedDates)
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        calendarView.delegate = datesDataBase
        return calendarView
    }

    func updateUIView(_ uiView: UICalendarView, context: Context) {
        datesDataBase.updateCompletedDates(completedDates)
        uiView.setNeedsDisplay()
    }
}

// MARK: Delegado del calendario
class MyEventDatabase: NSObject, UICalendarViewDelegate {
    
    var completedDates: Set<DateComponents>

    init(completedDates: Set<DateComponents>) {
        self.completedDates = completedDates
    }

    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        let normalizedDateComponents = Set(completedDates.map { DateComponents(year: $0.year, month: $0.month, day: $0.day) })
        let normalizedDateComponent = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day)
        
        if normalizedDateComponents.contains(normalizedDateComponent) {
            return UICalendarView.Decoration.default(color: .red, size: .small)
        }
        return nil
    }
    
    func updateCompletedDates(_ newDates: Set<DateComponents>) {
        completedDates = newDates
    }
}
