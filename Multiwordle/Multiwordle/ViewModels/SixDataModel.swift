//
//  SixDataModel.swift
//  Multiwordle
//
//  Created by EJ Gaygay on 10/29/24.
//
/*
import SwiftUI

class SixDataModel: ObservableObject {
    @Published var guesses: [SixGuess] = []
    @Published var incorrectAttempts = [Int](repeating: 0, count: 6)
    @Published var toastText: String?
    @Published var showStats = false
    @Published var timeRemaining: Int = 0
    var timer: Timer?
    @AppStorage("hardMode") var hardMode = false
    
    var keyColors = [String : Color]()
    var matchedLetters = [String]()
    var misplacedLetters = [String]()
    var correctlyPlacedLetters = [String]()
    var selectedWord = ""
    var currentWord = ""
    var tryIndex = 0
    var inPlay = false
    var gameOver = false
    var toastWords = ["Genius", "Magnificent", "Impressive", "Splendid", "Great", "Phew"]
    var currentStat: Statistic
    var headToHead = false
    var dailyMode = false
    
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    var disabledKeys: Bool {
        !inPlay || currentWord.count == 6
    }
    
    var isTimeUp: Bool {
        return timeRemaining <= 0
    }
    
    init() {
        currentStat = Statistic.loadStat()
        newGame()
    }
    
    // MARK: - Setup
    func newGame() {
        populateDefaults()
        fetchRandomWord()
        correctlyPlacedLetters = [String](repeating: "-", count: 6)
        currentWord = ""
        inPlay = true
        timeRemaining = 120
        tryIndex = 0
        headToHead = false
        gameOver = false
        print(dailyMode)
        // Start the timer only if dailyMode is true
        if dailyMode {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer?.invalidate()
            self.timeIsUp()
        }
    }
    
    func timeIsUp() {
        inPlay = false
        gameOver = true
        showToast(with: "Time's up!")
        // Optionally handle any other logic needed when time's up
    }
    
    func populateDefaults() {
        guesses = []
        for index in 0...5 {
            guesses.append(SixGuess(index: index))
        }
        // reset keyboard colors
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColors[String(char)] = .notused
        }
        matchedLetters = []
        misplacedLetters = []
    }
    
    func fetchRandomWord() {
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?length=6") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let words = try? JSONDecoder().decode([String].self, from: data),
               let word = words.first {
                DispatchQueue.main.async {
                    self.selectedWord = word.uppercased() // Set the selected word in uppercase
                    print(self.selectedWord)
                }
            } else {
                DispatchQueue.main.async {
                    print("Selecting from common words")
                    self.selectedWord = Global.commonWords.randomElement()! // Fallback in case of error
                    print(self.selectedWord)
                }
            }
        }.resume()
    }
    
    // MARK: - Game Play
    func addToCurrentWord(_ letter: String) {
        guard inPlay && !isTimeUp else { return } // Ensure guesses can only be added while in play and time isn't up
        currentWord += letter
        updateRow()
    }
    
    
    
    func enterWord() {
        if currentWord == selectedWord {
            gameOver = true
            print("You Win")
            setCurrentGuessColors()
            currentStat.update(win: true, index: tryIndex)
            showToast(with: toastWords[tryIndex])
            inPlay = false
            stopTimer()
        } else {
            if verifyWord() {
                if hardMode {
                    if let toastString = hardCorrectCheck() {
                        showToast(with: toastString)
                        return
                    }
                    if let toastString = hardMisplacedCheck() {
                        showToast(with: toastString)
                        return
                    }
                }
                setCurrentGuessColors()
                tryIndex += 1
                currentWord = ""
                if tryIndex == 6 {
                    currentStat.update(win: false)
                    gameOver = true
                    inPlay = false
                    showToast(with: selectedWord)
                    stopTimer()
                }
            } else {
                withAnimation {
                    self.incorrectAttempts[tryIndex] += 1
                }
                showToast(with: "Not in word list.")
                incorrectAttempts[tryIndex] = 0
            }
        }
    }
    
    
    
    func removeLetterFromCurrentWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow() {
        let guessWord = currentWord.padding(toLength: 6, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }
    
    func verifyWord() -> Bool {
        return Global.commonWords.contains(currentWord)
    }
    
    func hardCorrectCheck() -> String? {
        let guessLetters = guesses[tryIndex].guessLetters
        for i in 0...5 {
            if correctlyPlacedLetters[i] != "-" {
                if guessLetters[i] != correctlyPlacedLetters[i] {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .ordinal
                    return "\(formatter.string(for: i + 1)!) letter must be `\(correctlyPlacedLetters[i])`."
                }
            }
        }
        return nil
    }
    
    func hardMisplacedCheck() -> String? {
        let guessLetters = guesses[tryIndex].guessLetters
        for letter in misplacedLetters {
            if !guessLetters.contains(letter) {
                return ("Must contain the letter `\(letter)`.")
            }
        }
        return nil
    }
    
    func setCurrentGuessColors() {
        let correctLetters = selectedWord.map { String($0) }
        var frequency = [String : Int]()
        for letter in correctLetters {
            frequency[letter, default: 0] += 1
        }
        for index in 0...5 {
            let correctLetter = correctLetters[index]
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if guessLetter == correctLetter {
                guesses[tryIndex].bgColors[index] = .good
                if !matchedLetters.contains(guessLetter) {
                    matchedLetters.append(guessLetter)
                    keyColors[guessLetter] = .good
                }
                if misplacedLetters.contains(guessLetter) {
                    if let index = misplacedLetters.firstIndex(where: {$0 == guessLetter}) {
                        misplacedLetters.remove(at: index)
                    }
                }
                correctlyPlacedLetters[index] = correctLetter
                frequency[guessLetter]! -= 1
            }
        }
        
        for index in 0...5 {
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if correctLetters.contains(guessLetter)
                && guesses[tryIndex].bgColors[index] != .good
                && frequency[guessLetter]! > 0 {
                guesses[tryIndex].bgColors[index] = .misplace
                if !misplacedLetters.contains(guessLetter) && !matchedLetters.contains(guessLetter) {
                    misplacedLetters.append(guessLetter)
                    keyColors[guessLetter] = .misplace
                }
                frequency[guessLetter]! -= 1
            }
        }
        
        for index in 0...5 {
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if keyColors[guessLetter] != .good
                && keyColors[guessLetter] != .misplace {
                keyColors[guessLetter] = .bad
            }
        }
        flipCards(for: tryIndex)
    }
    
    func flipCards(for row: Int) {
        for col in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * 0.2) {
                self.guesses[row].cardFlipped[col].toggle()
            }
        }
    }
    
    func showToast(with text: String?) {
        withAnimation {
            toastText = nil
            
            guard let message = text else { return }
            
            /*
             if headToHead {
             if playerOne {
             toastText = "\(message), Player 1!"
             } else {
             toastText = "\(message), Player 2!"
             }
             } else {
             */
            toastText = message
            /*
             }
             }
             */
            withAnimation(Animation.linear(duration: 0.2).delay(3)) {
                toastText = nil
                if gameOver {
                    withAnimation(Animation.linear(duration: 0.2).delay(3)) {
                        showStats.toggle()
                    }
                }
            }
        }
        
    }
}
*/
