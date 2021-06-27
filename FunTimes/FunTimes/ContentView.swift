//
//  ContentView.swift
//  FunTimes
//
//  Created by Johnny Wellington on 21/05/21.
//

import SwiftUI

enum GameMode {
    case SETUP, PLAYING, SCORE
}


struct Question: Hashable {
    let text: String
    let answer: Int
}


struct ContentView: View {
    @State private var howManyTables = 1
    @State private var multipliers = 1..<11
    @State private var howManyQuestionsOptions = ["5": 5, "10": 10, "20": 20, "All": .infinity]
    @State private var howManyQuestionsSelection: String = "All"
    @State private var mode: GameMode = .SETUP
    @State private var questions: [Question] = []
    @State private var currentQuestion = 0
    @State private var currentAnswer: String = ""
    @State private var answers: [Int] = []
    @State private var remainingQuestions = 0
    
    @ViewBuilder
    var body: some View {
        if mode == .SETUP {
            VStack {
                Stepper("How many tables: \(howManyTables)", value: $howManyTables, in: 1...12)
                
                Text("How many questions?")
                HStack {
                    ForEach(howManyQuestionsOptions.keys.sorted(), id: \.self) { option in
                        Button("\(option)") {
                            howManyQuestionsSelection = option
                        }
                        .frame(width: 60, height: 40, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8.0)
                        .scaleEffect(option == howManyQuestionsSelection ? 1.3 : 1.0)
                        .padding(3.0)
                        
                    }
                }
                Button("Start Game") {
                    mode = .PLAYING
                    startGame()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8.0)
                
            }
            
        } else if mode == .PLAYING {
            
            VStack {
                Text("Playing")
                    .padding()
                
                Text("Remaining: \(remainingQuestions)")
                    .padding()
                
                Text("Question")
                    .font(.headline)
                
                Text("\(getCurrentQuestion())?")
                
                TextField("Answer", text: $currentAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                Button("Confirm") {
                    confirmAnswer()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8.0)
                
                Button("Setup Game") {
                    reset()
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8.0)
            }
        } else if mode == .SCORE {
            
            Text("Score")
                .padding()
            
            List(getScoreList(), id: \.0) { each in
                Text("question: \(each.0)")
                Text("right answer: \(each.1)")
                Text("your answer: \(each.2)")
            }
            
            Button("Setup Game") {
                reset()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8.0)
        }
        
    }
    
    func pickQuestions(tables: Int, quantity: Double) {
        if quantity == .infinity {
            for t in 1...tables {
                for m in multipliers {
                    let question = Question(text: "\(t)x\(m)",
                                            answer: t * m)
                    questions.append(question)
                }
            }
            remainingQuestions = questions.count
            return
        }
        var counter = quantity
        while counter > 0 {
            let randomT = Int.random(in: 1...tables)
            let randomM = multipliers.randomElement()!
            let question = Question(text: "\(randomT)x\(randomM)",
                                    answer: randomT * randomM)
            if questions.contains(question) {
                continue
            }
            questions.append(question)
            counter -= 1
        }
        remainingQuestions = questions.count
        return
    }
    
    func startGame() {
        let howManyQuestions = howManyQuestionsOptions[howManyQuestionsSelection]!
        pickQuestions(tables: howManyTables, quantity: howManyQuestions)
    }
    
    func getCurrentQuestion() -> String {
        questions[currentQuestion].text
    }
    
    func confirmAnswer() {
        answers.append(Int(currentAnswer)!)
        currentQuestion += 1
        currentAnswer = ""
        remainingQuestions -= 1
        if remainingQuestions == 0 {
            mode = .SCORE
        }
    }
    
    func getScoreList() -> [(String, Int, Int)] {
        var scoreList: [(String, Int, Int)] = []
        for (question, answer) in zip(questions, answers) {
            scoreList.append((question.text, question.answer, answer))
        }
        return scoreList
    }
    
    func reset() {
        mode = .SETUP
        howManyQuestionsSelection = "All"
        questions = []
        answers = []
        currentQuestion = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
