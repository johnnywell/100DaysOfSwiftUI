//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Johnny Wellington on 09/05/21.
//

import SwiftUI


struct LargeBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    
}

extension View {
    func largeBlue() -> some View {
        self.modifier(LargeBlue())
    }
}

struct ContentView: View {

    var body: some View {
            Text("Hello World")
                .largeBlue()
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
