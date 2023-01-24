//
//  ContentView.swift
//  TempConv
//
//  Created by Adri on 23/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var initialTemperature = 0.0
    @State private var fromSelection = UnitTemperature.celsius
    @State private var toSelection = UnitTemperature.celsius
    
    private let units = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    private var finalTemperature : Double {
        
        let initial = Measurement(value: initialTemperature, unit: fromSelection)
        let result = initial.converted(to: toSelection)
        
        return result.value
        
    }
    
    var body: some View {
        NavigationView{
                Form {
                    Section {
                        TextField("Enter a number in ", value: $initialTemperature, format: .number)
                        .keyboardType(.decimalPad)

                    } header: {
                       Text("Temperature to convert")
                    }
                    
                    Section{
                        Picker("Select the current unit", selection: $fromSelection) {
                            ForEach(units, id: \.self) { unit in
                                Text(MeasurementFormatter().string(from: unit).capitalized)
                            }
                        }
                    }
                    
                    Section{
                        Picker("Select the target unit", selection: $toSelection) {
                            ForEach(units, id: \.self) { unit in
                                Text(MeasurementFormatter().string(from: unit).capitalized)
                            }
                        }
                    }
                    
                    Section {
                        Text(String(format: "%.2f", finalTemperature) + " " +  (MeasurementFormatter().string(from: toSelection).capitalized))
                    } header: {
                        Text("Result")
                    }
                }.navigationTitle("TempConv")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
