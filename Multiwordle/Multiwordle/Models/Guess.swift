//
//  Guess.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/27/24.
//

/*
  The guess model
 */
import SwiftUI

struct Guess {
    let index: Int
    var word = "     "
    var bgColors = [Color](repeating: .wrong, count: 5)
    var cardFlipped = [Bool](repeating: false, count: 5)
    var guessLetters: [String] {
        word.map { String($0) }
    }
    
    // 🟨🟩🟩🟩⬛
    var results: String {
        let tryColors: [Color : String] = [.misplace : "🟨", .good : "🟩", .notused : "⬛"]
        return bgColors.compactMap {tryColors[$0]}.joined(separator: "")
    }
}
