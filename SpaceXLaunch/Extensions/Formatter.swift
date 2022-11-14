//
//  Formatter.swift
//  SpaceXLaunch
//
//  Created by MM on 14.11.2022.
//

import SwiftUI

extension Double {
    
    private var doubleFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    private var doubleFormatter3: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter
    }
    
    private var currencyFormatter0: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumSignificantDigits = 2
        return formatter
    }
    
    
    func formatter1dec() -> String {
        let num = NSNumber(value: self)
        return doubleFormatter.string(from: num) ?? "0.0"
    }
    
    func formatter3dec() -> String {
        let num = NSNumber(value: self)
        return doubleFormatter3.string(from: num) ?? "0.000"
    }
    
    func formatterCurrency() -> String {
        let num = NSNumber(value: self)
        return currencyFormatter0.string(from: num) ?? "$0.0"
    }
    
    func formatUsingAbbrevation () -> String {
            let numFormatter = NumberFormatter()

            typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
            let abbreviations:[Abbrevation] = [(0, 1, ""),
                                               (1000.0, 1000.0, "K"),
                                               (100_000.0, 1_000_000.0, " mln"),
                                               (100_000_000.0, 1_000_000_000.0, "bil")]// you can add more !

            let startValue = Double (abs(self))
            let abbreviation:Abbrevation = {
                var prevAbbreviation = abbreviations[0]
                for tmpAbbreviation in abbreviations {
                    if (startValue < tmpAbbreviation.threshold) {
                        break
                    }
                    prevAbbreviation = tmpAbbreviation
                }
                return prevAbbreviation
            } ()

            let value = Double(self) / abbreviation.divisor
            numFormatter.positiveSuffix = abbreviation.suffix
            numFormatter.negativeSuffix = abbreviation.suffix
            numFormatter.currencyCode = "USD"
            numFormatter.currencySymbol = "$"
            numFormatter.allowsFloats = true
            numFormatter.minimumIntegerDigits = 1
            numFormatter.minimumFractionDigits = 0
            numFormatter.maximumFractionDigits = 1
            numFormatter.numberStyle = .currency

        return "$\(numFormatter.string(from: NSNumber (value:value))!)"
        }
    
}

extension Int {
    
    func intToDateFormatter() -> String {
        let num = NSNumber(value: self)
        var date = Date()
        date = NSDate(timeIntervalSince1970: TimeInterval(truncating: num)) as Date
        return date.formatted(.dateTime.day().month(.wide).year())
    }
}
