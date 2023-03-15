//
//  ContentView.swift
//  Prueba-01-100days
//
//  Created by Kevin Hernandez on 14/03/23.
//

import SwiftUI

struct ContentView: View {
    
    enum ListUnit: String, CaseIterable {
        case Temperatura
        case Tiempo
        case Medida
        case Distancia
    }
    
    enum UnitTemp: String, CaseIterable {
        case celsius
        case fahrenheit
        case kelvin
    }
    
    enum UnitTime: String, CaseIterable  {
        case seconds
        case minutes
        case hours
    }
    
    enum UnitMedida: String, CaseIterable  {
        case pints
        case gallons
        case cups
        case liters
        case milliliters
    }
    
    enum UnitDistance: String, CaseIterable {
        case meters
        case kilometers
        case feet
        case yards
        case miles
    }

    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var inputUnitTemp : UnitTemp = .celsius
    @State private var outputUnitTemp : UnitTemp = .fahrenheit
    @State private var inputUnitTime : UnitTime = .seconds
    @State private var outputUnitTime : UnitTime = .minutes
    @State private var inputUnitMedida : UnitMedida = .gallons
    @State private var outputUnitMedida : UnitMedida = .liters
    @State private var inputUnitDistance : UnitDistance = .miles
    @State private var outputDistance : UnitDistance = .kilometers
    @State private var listUnitFrom = ListUnit.Temperatura
    
    func temperatureConversionSection<T>(selection: Binding<T>, selectionOut: Binding<T>) -> some View where T: Hashable {
        Section(header: Text(listUnitFrom.rawValue)) {
            Picker("From", selection: selection) {
                switch listUnitFrom {
                    case .Temperatura:
                        ForEach(UnitTemp.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    case .Tiempo:
                        ForEach(UnitTime.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    case .Medida:
                        ForEach(UnitMedida.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    case .Distancia:
                        ForEach(UnitDistance.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                }
                
            }.pickerStyle(SegmentedPickerStyle())
            
            TextField("Value", text: $inputValue)
                .keyboardType(.decimalPad)
            
            Picker("To", selection: selectionOut) {
                switch listUnitFrom {
                    case .Temperatura:
                        ForEach(UnitTemp.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    case .Tiempo:
                        ForEach(UnitTime.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    case .Medida:
                        ForEach(UnitMedida.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    case .Distancia:
                        ForEach(UnitDistance.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            Text(outputValue)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                //seccion lista de unidades
            
                Section(header: Text("CHOOSE CONVERSION TYPE")) {
                    Picker("Conversion Type:", selection: $listUnitFrom) {
                        ForEach(ListUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }

                
                if listUnitFrom.rawValue == "Temperatura" {
                    temperatureConversionSection(selection: $inputUnitTemp, selectionOut: $outputUnitTemp)
                    Button("Convert", action: {
                        guard let inputValue = Double(inputValue) else {
                            outputValue = ""
                            return
                        }
                        
                        var inputTemp: Measurement<UnitTemperature>
                        var outputTemp: Measurement<UnitTemperature>
                        
                        switch inputUnitTemp {
                            case .celsius:
                                inputTemp = Measurement(value: inputValue, unit: .celsius)
                            case .fahrenheit:
                                inputTemp = Measurement(value: inputValue, unit: .fahrenheit)
                            case .kelvin:
                                inputTemp = Measurement(value: inputValue, unit: .kelvin)
                        }
                
                        switch outputUnitTemp {
                            case .celsius:
                                outputTemp = inputTemp.converted(to: .celsius)
                            case .fahrenheit:
                                outputTemp = inputTemp.converted(to: .fahrenheit)
                            case .kelvin:
                                outputTemp = inputTemp.converted(to: .kelvin)
                        }
                        
                        outputValue = String(format: "%.2f", outputTemp.value)
                    })
                }
                
                if listUnitFrom.rawValue == "Tiempo" {
                    temperatureConversionSection(selection: $inputUnitTime, selectionOut: $outputUnitTime)
                    Button("Convert", action: {
                        guard let inputValue = Double(inputValue) else {
                            outputValue = ""
                            return
                        }
                        
                        var inputTime: Measurement<UnitDuration>
                        var outputTime: Measurement<UnitDuration>
                        
                        
                        switch inputUnitTime {
                        case .seconds:
                            inputTime = Measurement(value: inputValue, unit: .seconds)
                        case .minutes:
                            inputTime = Measurement(value: inputValue, unit: .minutes)
                        case .hours:
                            inputTime = Measurement(value: inputValue, unit: .hours)
                        }
                
                        switch outputUnitTime {
                        case .seconds:
                            outputTime = inputTime.converted(to: .seconds)
                        case .minutes:
                            outputTime = inputTime.converted(to: .minutes)
                        case .hours:
                            outputTime = inputTime.converted(to: .hours)
                        }
                        
                        outputValue = String(format: "%.2f", outputTime.value)
                    })
                }
                
                if listUnitFrom.rawValue == "Medida" {
                    temperatureConversionSection(selection: $inputUnitMedida, selectionOut: $outputUnitMedida)
                    Button("Convert", action: {
                        guard let inputValue = Double(inputValue) else {
                            outputValue = ""
                            return
                        }
                        
                        var inputMedida: Measurement<UnitVolume>
                        var outputMedida: Measurement<UnitVolume>
                        
                        switch inputUnitMedida {
                            case .milliliters:
                                inputMedida = Measurement(value: inputValue, unit: .milliliters)
                            case .liters:
                                inputMedida = Measurement(value: inputValue, unit: .liters)
                            case .cups:
                                inputMedida = Measurement(value: inputValue, unit:  .cups)
                            case .pints:
                                inputMedida = Measurement(value: inputValue, unit: .pints)
                            case .gallons:
                                inputMedida = Measurement(value: inputValue, unit: .gallons)
                        }
                    
                        switch outputUnitMedida {
                            case .milliliters:
                                outputMedida = inputMedida.converted(to: .milliliters)
                            case .liters:
                                outputMedida = inputMedida.converted(to: .liters)
                            case .cups:
                                outputMedida = inputMedida.converted(to: .cups)
                            case .pints:
                                outputMedida = inputMedida.converted(to: .pints)
                            case .gallons:
                                outputMedida = inputMedida.converted(to: .gallons)
                        }
                        
                        outputValue = String(format: "%.2f", outputMedida.value)
                    })
                }
                
                
                if listUnitFrom.rawValue == "Distancia" {
                    temperatureConversionSection(selection: $inputUnitDistance, selectionOut: $outputDistance)
                    Button("Convert", action: {
                        guard let inputValue = Double(inputValue) else {
                            outputValue = ""
                            return
                        }
                        
                        var inputDistancia: Measurement<UnitLength>
                        var outputDistancia: Measurement<UnitLength>
                        
                        switch inputUnitDistance {
                            case .meters:
                                inputDistancia = Measurement(value: inputValue, unit: .meters)
                            case .kilometers:
                                inputDistancia = Measurement(value: inputValue, unit: .kilometers)
                            case .feet:
                                inputDistancia = Measurement(value: inputValue, unit: .feet)
                            case .yards:
                                inputDistancia = Measurement(value: inputValue, unit: .yards)
                            case .miles:
                                inputDistancia = Measurement(value: inputValue, unit: .miles)
                        }
                    
                        switch outputDistance {
                            case .meters:
                                outputDistancia = inputDistancia.converted(to: .meters)
                            case .kilometers:
                                outputDistancia = inputDistancia.converted(to: .kilometers)
                            case .feet:
                                outputDistancia = inputDistancia.converted(to: .feet)
                            case .yards:
                                outputDistancia = inputDistancia.converted(to: .yards)
                            case .miles:
                                outputDistancia = inputDistancia.converted(to: .miles)
                        }
                        
                        outputValue = String(format: "%.2f", outputDistancia.value)
                    })
                }
                
            }
            .navigationTitle("Unit Converter")
        }
    }
}

        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
