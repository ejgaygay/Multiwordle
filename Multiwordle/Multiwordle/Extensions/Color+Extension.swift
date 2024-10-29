//
//  Color+Extension.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/27/24.
//
import SwiftUI

extension Color {
    static var bad: Color {
        Color(UIColor(named: "wrong")!)
    }
    static var misplace: Color {
        Color(UIColor(named: "misplaced")!)
    }
    static var good: Color {
        Color(UIColor(named: "correct")!)
    }
    static var notused: Color {
        Color(UIColor(named: "unused")!)
    }
    static var systemBackground: Color {
        Color(.systemBackground)
    }
}
