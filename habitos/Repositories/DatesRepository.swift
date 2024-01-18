//
//  DatesRepository.swift
//  habitos
//
//  Created by Víctor Alba on 18/1/24.
//

import Foundation

struct DatesRepository {

    
    func saveLastResetDate(date: Date) throws {
            UserDefaults.standard.set(date, forKey: "lastResetDate")
        }

    func getLastResetDate() throws -> Date {
        guard let lastDate = UserDefaults.standard.object(forKey: "lastResetDate") as? Date
        else {
            return Date.now
            // no sé si esto joderá la lógica del reseteo de habitos
        }
        return lastDate
    }
    
}

