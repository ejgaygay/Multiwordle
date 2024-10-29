//
//  LetterButtonView.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/27/24.
//

/*
  Individual letter for the KB
 */
import SwiftUI

struct LetterButtonView: View {
    @EnvironmentObject var dm: DataModel
    var letter: String
    var body: some View {
        Button {
            dm.addToCurrentWord(letter)
        } label: {
            Text(letter)
                .font(.system(size: 20))
                .frame(width: 35, height: 50)
                .background(dm.keyColors[letter])
                .foregroundColor(.primary)
        }
        .buttonStyle(.plain)
    }
}

struct LetterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LetterButtonView(letter: "L")
            .environmentObject(DataModel())
    }
}
