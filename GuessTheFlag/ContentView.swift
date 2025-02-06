//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Collis on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var resultText = ""
    
    @State private var playerScore = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.7, blue: 0.3), Color.orange]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    VStack {
                        Text("Tap the flag of")
                        Text(countries[correctAnswer])
                            .bold()
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            isAnswerCorrect(selectedIndex: number)
                        } label: {
                            Image(countries[number])
                        }
                    }
                    .alert(resultText, isPresented: $showingScore) {
                        Button("Continue") {nextQuestion()}
                    } message: {
                        Text("Score: \(playerScore)")
                    }
                    
                    Spacer()
                    Text("Score: \(playerScore)")
                    Spacer()
                }
            }
            .navigationTitle("Guess the Flag")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func isAnswerCorrect(selectedIndex: Int) {
        if correctAnswer == selectedIndex {
            resultText = "Correct!"
            playerScore += 1
        } else {
            resultText = "Wrong"
            if playerScore != 0 {
                playerScore -= 1
            }
        }
        showingScore = true
    }
    
    func nextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
