//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Johnny Wellington on 11/05/21.
//

import SwiftUI


struct Score: View {
    let score: Int
    var body: some View {
        Text("Score: \(score)")
    }
}


struct Move: View {
    let move: String
    var body: some View {
        Text("Move: \(move)")
    }
}


struct Goal: View {
    let goal: String
    var body: some View {
        Text("Goal: \(goal)")
    }
}



struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var turns = 1
    @State private var endGame = false
    
    var body: some View {
        VStack {
            Score(score: score)
            Move(move: moves[currentMove])
            Goal(goal: shouldWin ? "Win" : "Lose")
            
            HStack {
                ForEach(moves, id: \.self) { move in
                    Button(action: {
                        computeMove(moves.firstIndex(of: move)!)
                    }) {
                        Text(move)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    
                }
            }
            .alert(isPresented: $endGame) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("Your score is: \(score)"),
                    primaryButton: .default(Text("Play Again"), action: playAgain),
                    secondaryButton: .destructive(Text("Enter endless mode"))
                )
            }
        }
    }
    
    func computeMove(_ move: Int) {
        if shouldWin && (move - currentMove == 1 || move - currentMove == -2) {
            score += 1
        } else if currentMove - move == 1 || currentMove - move == -2{
            score += 1
        } else {
            score -= score > 0 ? 1 : 0
        }
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        turns += 1
        endGame = turns == 10 ? true : false
        
    }
    
    func playAgain() {
        score = 0
        turns = 1
        currentMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
