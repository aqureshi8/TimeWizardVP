//
//  ContentView.swift
//  TimeWizardVP
//
//  Created by Ahsan Qureshi on 3/10/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var inputUnit = "Seconds"
    @State private var outputUnit = "Seconds"
    @State private var inputTime = 0.0
    
    private var timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    private var timeConversion = [60, 60, 24, 1]
    private var outputTime: Double {
        var inputIndex = timeUnits.firstIndex(of: inputUnit) ?? 0
        let outputIndex = timeUnits.firstIndex(of: outputUnit) ?? 0
        var outputValue = inputTime
        while(inputIndex != outputIndex) {
            if (inputIndex > outputIndex) {
                inputIndex -= 1
                outputValue *= Double(timeConversion[inputIndex])
            } else {
                outputValue /= Double(timeConversion[inputIndex])
                inputIndex += 1
            }
        }
        return outputValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Unit") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output Unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Input time in (\(inputUnit))") {
                    TextField("Input Time", value: $inputTime, format: .number)
                        .keyboardType(.numberPad)
                }
                Section("Output time in (\(outputUnit))") {
                    Text(outputTime, format: .number)
                }

            }
            .navigationTitle("TimeWizardVP")
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
