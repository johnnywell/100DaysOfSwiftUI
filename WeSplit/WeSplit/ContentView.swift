//
//  ContentView.swift
//  WeSplit
//
//  Created by Johnny Wellington on 01/05/21.
//

import SwiftUI 

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var tipPercentage = 2
    @State private var numberOfPeople = ""
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalCheck: Double {
         // Fix off by two of the array
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let amountPerPerson = totalCheck / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text ("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total for the check")) {
                    Text("$\(totalCheck, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
