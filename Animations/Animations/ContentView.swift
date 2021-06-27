//
//  ContentView.swift
//  Animations
//
//  Created by Johnny Wellington on 18/05/21.
//

import SwiftUI

struct CornerRotationModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotationModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotationModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
//    @State private var isShowingRed = false
//    @State private var dragAmount = CGSize.zero
    @State private var animationAmount = 0.0
    
    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//            }
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.pivot)
//
//            }
//        }
        
        
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? Color.blue : Color.red)
//                    .foregroundColor(.white)
//                    .offset(dragAmount)
//                    .animation(.default.delay(Double(num) / 20))
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
        
        
        
//
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged { dragAmount = $0.translation }
//                    .onEnded {_ in
//                        withAnimation(.spring()){
//                            dragAmount = .zero }
//                        }
//            )
            
        
        
//        Button("Tap Me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? Color.blue : Color.red)
//        .animation(nil)
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        
        
        Button("Tap Me") {
            withAnimation() {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0)
//            anchor: .top,
//            perspective: CGFloat(1.2)
        )
        
        
//        print(animationAmount)
//
//        return VStack {
//            Stepper("Scale amount",
//                    value: $animationAmount.animation(
//                        .easeInOut(duration: 1)
//                        .repeatCount(3, autoreverses: true)),
//                    in: 1...10)
//
//            Spacer()
//
//            Button("Tap Me") {
//                animationAmount += 1
//            }
//            .padding(40)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
        
        
        
//        Button("Tap me") {

//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .overlay(
//            Circle()
//                .stroke(Color.red)
//                .scaleEffect(animationAmount)
//                .opacity(Double(2 - animationAmount))
//                .animation(
//                    .easeInOut(duration: 1)
//                        .repeatForever(autoreverses: false)
//                )
//        )
//        .onAppear {
//            animationAmount = 2
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
