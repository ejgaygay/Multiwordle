//
//  DailyView.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/28/24.
//


import SwiftUI

struct DailyView: View {
    @EnvironmentObject var dm: DataModel
    @State private var showSettings = false
    @State private var showHelp = false
    var body: some View {
        ZStack {
        NavigationView {
            VStack {
                if Global.screenHeight < 600 {
                    Text("")
                }
                Text("Time Remaining: \(dm.timeRemaining) seconds")
                    .font(.headline)
                    .padding()
                Spacer()
                VStack(spacing: 3) {
                    ForEach(0...5, id: \.self) { index in
                        NormalGuessView(guess: $dm.guesses[index])
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
        }.onAppear{
            print("hi")
            dm.dailyMode = true
            dm.stopTimer()
            dm.newGame()
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showHelp) {
            HelpView()
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
            .environmentObject(DataModel())
    }
}

