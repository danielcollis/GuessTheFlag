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
    
    @State private var playerScore = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.7, blue: 0.3), Color.black]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
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
//                        ForEach(0..<4) {number in
//                            Button {
//                                isAnswerCorrect(selectedIndex: number)
//                            } label: {
//                                Image(countries[number])
//                                    .clipShape(.capsule)
//                                    .shadow(radius: 5)
//                            }
//                        }
                        
                        .alert(resultText, isPresented: $showingScore) {
                            Button("Continue") {nextQuestion()}
                        } message: {
                            Text("Score: \(playerScore)")
                        }
                        
                    }
                    .frame(maxWidth: 350)
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
        correctAnswer = Int.random(in: 0...5)
    }
}

#Preview {
    ContentView()
}
