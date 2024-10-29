//
//  SixGuessView.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/29/24.
//
/*

import SwiftUI

struct SixGuessView: View {
    @Binding var guess: SixGuess
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0...5, id: \.self) { index in
                FlipView(isFlipped: $guess.cardFlipped[index]) {
                    Text(guess.guessLetters[index])
                        .foregroundColor(.primary)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(Color.systemBackground)
                } back: {
                    Text(guess.guessLetters[index])
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .background(guess.bgColors[index])
                }
                .font(.system(size: 35, weight: .heavy))
                .border(Color(.secondaryLabel))
            }
        }
    }
}

struct SixGuessView_Preview: PreviewProvider {
    static var previews: some View {
        SixGuessView(guess: .constant(SixGuess(index: 0)))
    }
}

*/
