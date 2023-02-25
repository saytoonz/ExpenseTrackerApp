//
//  Extensions.swift
//  ExpenseTrackerApp
//
//  Created by Sam on 24/02/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}


extension DateFormatter {
    static let allNumericDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
       
        return formatter
    }()
}


extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericDate.date(from: self) else {
            return Date()
        }
        
        return parsedDate
    }
}
