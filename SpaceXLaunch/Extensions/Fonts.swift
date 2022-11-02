//
//  Fonts.swift
//  SpaceXLaunch
//
//  Created by MM on 31.10.2022.
//

import SwiftUI

extension Font {

    enum LabGrotesqueFont {
        case semibold
        case regular
        case bold
        case black
        case custom(String)
        case medium

        var value: String {
            switch self {
            case .semibold:
                return "LabGrotesque-Medium"
            case .regular:
                return "LabGrotesque-Regular"
            case .bold:
                return "LabGrotesque-Bold"
            case .black:
                return "LabGrotesque-Black"
            case .medium:
                return "LabGrotesque-Medium"

            case .custom(let name):
                return name
            }
        }
    }
    
    static func labGrotesque(_ type: LabGrotesqueFont, size: CGFloat = 26) -> Font {
        return .custom(type.value, size: size)
    }
}


