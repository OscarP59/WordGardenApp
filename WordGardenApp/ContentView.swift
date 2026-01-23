//
//  ContentView.swift
//  WordGardenApp
//
//  Created by PERLA, OSCAR on 1/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var gameStatusMessage = "How many Guesses to uncover the hidden word"
    @State private var currentWordIndex = 0 // index in
    @State private var wordToGuess = ""
    @State private var revealWord = ""
    @State private var guessedLetter = ""
    @State private var imageName  = "flower8"
    @State private var playAgainHidden = true
    @FocusState private  var textFieldIsFocused: Bool
    private let wordsToGuess = ["SWIFT, DOG, CAT"]
    @State private var lettersGuessed = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("words Gussed: \(wordsGuessed)")
                    Text("words Missed: \(wordsMissed)")
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("words to Gussed: \(wordsToGuess.count - (wordsGuessed + wordsMissed))")
                    Text("words in game:\(wordsToGuess.count)")
                }
            }
            .padding(.horizontal)
            
            Spacer()
            Text(gameStatusMessage )
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text(revealWord)
                .font(.title)
            
            if playAgainHidden {
                HStack{
                    TextField( "", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) {
                            guessedLetter =
                            guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else {
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .focused($textFieldIsFocused)
                        .onSubmit {
                            guard guessedLetter != "" else{
                                return
                            }
                            guessALetter()
                        }
                    
                    Button("Guess a letter") {
                        guessALetter()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                }
        }else{
                Button("Another word"){
//                    playAgainHidden = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            
              
            }
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .background(ignoresSafeAreaEdges: .bottom)
        .onAppear {
            wordToGuess = wordsToGuess[currentWordIndex]
            revealWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        }
    }
    func guessALetter () {
        textFieldIsFocused = false
        lettersGuessed = lettersGuessed + guessedLetter
        revealWord =  wordToGuess.map{ letter in
            lettersGuessed.contains(letter) ? "\(letter)" : "_"
        }.joined(separator: " ")
        guessedLetter = ""
    }
}

#Preview {
    ContentView()
}
