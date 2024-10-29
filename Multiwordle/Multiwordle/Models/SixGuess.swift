//
//  SixGuess.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/29/24.
//

import SwiftUI

struct SixGuess {
    let index: Int
    var word = "      "
    var bgColors = [Color](repeating: .wrong, count: 6)
    var cardFlipped = [Bool](repeating: false, count: 6)
    var guessLetters: [String] {
        word.map { String($0) }
    }
    
    // 🟨🟩🟩🟩⬛
    var results: String {
        let tryColors: [Color : String] = [.misplace : "🟨", .good : "🟩", .notused : "⬛"]
        return bgColors.compactMap {tryColors[$0]}.joined(separator: "")
    }
}
