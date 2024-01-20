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
