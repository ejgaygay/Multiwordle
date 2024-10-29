//
//  SixGameView.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/29/24.
//
/*
import SwiftUI

struct SixGameView: View {
    @EnvironmentObject var dm: SixDataModel
    @State private var showSettings = false
    @State private var showHelp = false
    var body: some View {
        ZStack {
        NavigationView {
            VStack {
                if Global.screenHeight < 600 {
                    Text("")
                }
                Spacer()
                VStack(spacing: 3) {
                    ForEach(0...6, id: \.self) { index in
                        SixGuessView(guess: $dm.guesses[index])
                            .modifier(Shake(animatableData: CGFloat(dm.incorrectAttempts[index])))
                    }
                }
                .frame(width: Global.boardWidth, height: 6 * Global.boardWidth / 5)
                Spacer()
                Keyboard()
                    .scaleEffect(Global.keyboardScale)
                    .padding(.top)
                Spacer()
            }
            .disabled(dm.showStats)
                .navigationBarTitleDisplayMode(.inline)
                .disabled(dm.showStats)
                .overlay(alignment: .top) {
                    if let toastText = dm.toastText {
                        ToastView(toastText: toastText)
                            .offset(y: 20)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            if !dm.inPlay {
                                Button {
                                    dm.newGame()
                                } label: {
                                    Text("New")
                                        .foregroundColor(.primary)
                                }
                            }
                            Button {
                                showHelp.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("WORDLE")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(dm.hardMode ? Color(.systemRed) : .primary)
                            .minimumScaleFactor(0.5)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                withAnimation {
                                    dm.currentStat = Statistic.loadStat()
                                    dm.showStats.toggle()
                                }
                            } label: {
                                Image(systemName: "chart.bar")
                            }
                        }
                    }
                }
        }
            if dm.showStats {
                StatsView()
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showHelp) {
            HelpView()
        }
    }
}

struct SixGameView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataModel = SixDataModel()
        mockDataModel.guesses = Array(repeating: SixGuess(index: 0), count: 6) // Ensure guesses are initialized
        return SixGameView()
            .environmentObject(mockDataModel)
    }
}
*/
