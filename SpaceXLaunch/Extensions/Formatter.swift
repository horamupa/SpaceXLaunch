//
//  Formatter.swift
//  SpaceXLaunch
//
//  Created by MM on 14.11.2022.
//

import SwiftUI

extension String {
    private var dateFormatter13: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-m-d   HH:mm E, d MMM y"
        return formatter
    }
}

//extension Int {
//    private var intToDateFormatter:
//}
extension Int {
    
    
//    private var intToDateForm:
    
    func intToDateFormatter() -> String {
        let num = NSNumber(value: self)
        var date = Date()
        date = NSDate(timeIntervalSince1970: TimeInterval(truncating: num)) as Date
        return date.formatted(.dateTime.day().month(.wide).year())
    }
}
//date.formatted(.dateTime.day().month().year())
