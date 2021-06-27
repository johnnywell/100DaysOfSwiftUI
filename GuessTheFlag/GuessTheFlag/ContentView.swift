//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Johnny Wellington on 05/05/21.
//

import SwiftUI


struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var selection: Int = 0
    @State private var offsetAmount = CGFloat.zero
    
    @State private var selectedFlag = 0
    @State private var besidesTheCorrect = false
    @State private var animateOpacity = 1.0
    @State private var besidesTheWrong = false
    @State private var offsetReturnAmount = CGFloat.zero
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30 ){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .animation(.linear)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        selectedFlag = number
                        flagTapped(number)
                    }) {
                        FlagImage(country: self.countries[number])
                    }
//                    .rotation3DEffect(
//                        .degrees(number == correctAnswer ? spinAmount : 0.0),
//                        axis: (x: 0.0, y: 1.0, z: 0.0)
//                    )
                    .offset(x: number == correctAnswer ? offsetAmount : CGFloat.zero, y: CGFloat.zero)
                    .opacity(number != correctAnswer && besidesTheCorrect ? animateOpacity : 1.0)
                    .background(besidesTheWrong && selectedFlag == number ? Capsule(style: .circular).fill(Color.red).blur(radius:30) : Capsule(style: .circular).fill(Color.clear).blur(radius: 0))
                    .opacity(besidesTheWrong && selectedFlag != number ? animateOpacity : 1.0)
                }
                
                Spacer()
                
                Button("Shuffle") {
                    askQuestion()
                }
                
                Spacer()
                
                Text("Your score is: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                Spacer()
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        selection = number
        if selection == correctAnswer {
            score += 1
            
            
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 1)) {
                offsetAmount = -20
                offsetReturnAmount = 20
                animateOpacity = 0.25
                besidesTheCorrect = true
            }
        } else {
            score = score > 0 ? score - 1 : 0
            
            withAnimation {
                animateOpacity = 0.25
                besidesTheWrong = true
            }
        }
        
    }
    
    func askQuestion() {
        offsetAmount = CGFloat.zero
        offsetReturnAmount = CGFloat.zero
        besidesTheCorrect = false
        besidesTheWrong = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
