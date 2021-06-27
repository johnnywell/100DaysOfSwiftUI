//
//  ContentView.swift
//  BetterRest
//
//  Created by Johnny Wellington on 12/05/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 0
    @State private var bedtime = defaultBedtime
    
    var body: some View {
        
        let wakeUpBinding = Binding<Date> (
            get: { self.wakeUp },
            set: {
                self.wakeUp = $0
                calculateBedtime()
            }
        )
        
        let sleepAmountBinding = Binding (
            get: { self.sleepAmount },
            set: {
                self.sleepAmount = $0
                calculateBedtime()
            }
        )
        
        let coffeAmountBinding = Binding (
            get: { self.coffeAmount },
            set: {
                self.coffeAmount = $0
                calculateBedtime()
            }
        )
        
        return NavigationView{
            VStack {
                 
                
                
                
                Form {
                    Section(header: Text("When do you want to wake up?")) {
                        DatePicker("Please enter a time",
                                   selection: wakeUpBinding,
                                   displayedComponents:
                                    .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    Section(header: Text("Desired amount of sleep")) {
                        
                        Stepper(value: sleepAmountBinding, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    
                    Section(header: Text("Daily coffe intake")) {
                        
                        Picker("Daily coffe intake", selection: coffeAmountBinding) {
                            ForEach(1..<21) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                    }
                    
                }
                .navigationBarTitle("BetterRest")
             
                Label("Bedtime \(bedtime)", systemImage: "clock")
                    .font(.title)
            }
        }
        
       
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    static var defaultBedtime: String {
        var components = DateComponents()
        components.hour = 23
        components.minute = 0
        let sleepTime = Calendar.current.date(from: components) ?? Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        return formatter.string(from: sleepTime)
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount + 1))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            bedtime = formatter.string(from: sleepTime)
        } catch {
            // catch error
        }
    
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
