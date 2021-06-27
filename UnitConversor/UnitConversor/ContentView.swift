//
//  ContentView.swift
//  UnitConversor
//
//  Created by Johnny Wellington on 04/05/21.
//

import SwiftUI

struct ContentView: View {
    @State var inputValue = ""
    @State var inputUnit = "meters"
    @State var outputUnit = "meters"
    let formatter: MeasurementFormatter
    
    let units = [
        "meters": UnitLength.meters,
        "kilometers": UnitLength.kilometers,
        "feet": UnitLength.feet,
        "yards": UnitLength.yards,
        "miles": UnitLength.miles
    ]
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        let localeIdentifier = UserDefaults.standard.object(forKey: "locale") ?? "pt_BR"
        let locale = Locale(identifier: localeIdentifier as! String)
        formatter.locale = locale
    }
    
    var outputMeasurement: Measurement<UnitLength> {
        let inputMeasurement = Measurement(value: Double(inputValue) ?? 0, unit: units[inputUnit]!)
        let outputMeasurement = inputMeasurement.converted(to: units[outputUnit]!)
        return outputMeasurement
    }
    
    var formattedOutputMeasuremente: String {
        formatter.string(from: outputMeasurement)
    }
        
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    
                    TextField("Value", text: $inputValue)
                    
                    Picker(selection: $inputUnit, label: Text("Unit")) {
                        ForEach(units.keys.sorted(), id: \.self) { key in
                            Text("\(units[key]!.symbol)").tag(key)
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    
                    Picker(selection: $outputUnit, label: Text("Unit")) {
                        ForEach(units.keys.sorted(), id: \.self) { key in
                            Text("\(units[key]!.symbol)").tag(key)
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text(formattedOutputMeasuremente)
                }
            }
            .navigationBarTitle(Text("Unity Converter"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
