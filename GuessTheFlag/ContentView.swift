//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Collis on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...5)
    
    @State private var showingScore = false
    @State private var resultText = ""
    @State private var clarificationText = ""
    
    @State private var playerScore = 0
    @State private var questionNumber = 1
    let maxQuestionNumber = 8
    
    var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.7, blue: 0.3), Color.black]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Guess The Flag")
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                    Text("Question \(questionNumber)")
                        .font(.title)
                    Spacer()
                    
                    VStack(spacing: 25) {
                        VStack {
                            Text("Tap the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        HStack {
                            ForEach(0..<2) {number in
                                Button {
                                    isAnswerCorrect(selectedIndex: number)
                                } label : {
                                    Image(countries[number])
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.capsule)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        HStack {
                            ForEach(2..<4) {number in
                                Button {
                                    isAnswerCorrect(selectedIndex: number)
                                } label : {
                                    Image(countries[number])
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.capsule)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        HStack {
                            ForEach(4..<6) {number in
                                Button {
                                    isAnswerCorrect(selectedIndex: number)
                                } label : {
                                    Image(countries[number])
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.capsule)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .alert(resultText, isPresented: $showingScore) {
                            Button((questionNumber == maxQuestionNumber) ? "Restart" : "Continue") {nextQuestion()}
                        } message: {
                            Text(questionNumber == maxQuestionNumber ? readFinalScore() : readPlayerScore())
                        }
                        
                    }
//                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score: \(playerScore)")
                        .foregroundStyle(Color(red: 1.0, green: 0.7, blue: 0.3))
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                }
                .padding()
            }
    }
    func isAnswerCorrect(selectedIndex: Int) {
        if correctAnswer == selectedIndex {
            resultText = "Correct!"
            playerScore += 1
        } else {
            resultText = "Wrong"
        }
        clarificationText = "That's the flag of \(countries[selectedIndex])"
        showingScore = true
    }
    
    func readPlayerScore() -> String {
        """
        \(clarificationText)
        Score: \(playerScore)
        """
    }
    
    func readFinalScore() -> String {
        """
        \(clarificationText)
        Final Score: \(Double(playerScore) / Double(maxQuestionNumber) * 100)%
        """
    }
    
    func nextQuestion() {
        questionNumber += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...5)
        if questionNumber > maxQuestionNumber {
            restartGame()
        }
    }
    
    func restartGame() {
        playerScore = 0
        questionNumber = 1
    }
}

#Preview {
    ContentView()
}
