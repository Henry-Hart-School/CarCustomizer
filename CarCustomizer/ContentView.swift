//
//  ContentView.swift
//  CarCustomizer
//
//  Created by Hart, Henry (AGDF) on 16/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var starterCars = StarterCars()

    @State private var selectedCar : Int = 0
    
    @State private var exhaustPackage = false
    
    @State private var tiresPackage = false
    
    @State private var accelPackage = false
    
    @State private var allPackage = false
    
    @State private var remainingFunds : Int = 10
    
    @State private var remainingTime : Int = 30
    
    @State private var locked = false
    
    
    //let accel_formatted = String(format: "%.2f", car.acceleration)
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: { val in
                self.exhaustPackage = val
                if val {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 1
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 1
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: {self.tiresPackage},
            set: { val in
                self.tiresPackage = val
                if val {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 2
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 2
                }
            }
        )
        
        let accelPackageBinding = Binding<Bool> (
            get: {self.accelPackage},
            set: { val in
                self.accelPackage = val
                if val {
                    starterCars.cars[selectedCar].acceleration += 10
                    remainingFunds -= 3
                } else {
                    starterCars.cars[selectedCar].acceleration -= 10
                    remainingFunds += 3
                }
            }
        )
        
        let allPackageBinding = Binding<Bool> (
            get: {self.allPackage},
            set: { val in
                self.allPackage = val
                if val {
                    starterCars.cars[selectedCar].topSpeed += 5
                    starterCars.cars[selectedCar].handling += 2
                    starterCars.cars[selectedCar].acceleration += 10
                    remainingFunds -= 4
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    starterCars.cars[selectedCar].handling -= 2
                    starterCars.cars[selectedCar].acceleration -= 10
                    remainingFunds += 4
                }
            }
        )
        VStack {
            Text("\(remainingTime)").onReceive(timer) { _ in
                if self.remainingTime > 1 {
                    self.remainingTime -= 1
                }
                else {
                    self.remainingTime = 0
                    locked = true
                    
                }
            }.foregroundColor(.red)
            Form {
            VStack(alignment: .leading, spacing: 20) {
                Text(starterCars.cars[selectedCar].stringify())
                Button("Next Car") {
                    selectedCar =  (selectedCar + 1) % self.starterCars.cars.count
                    // reset
                    exhaustPackage = false
                    
                    tiresPackage = false
                    
                    accelPackage = false
                    
                    allPackage = false
                    
                    remainingFunds = 10
                }.disabled(locked)
                Section {
                    Toggle("Exhaust Package (Cost: 1)", isOn: exhaustPackageBinding).disabled(locked || remainingFunds < 1 && !exhaustPackage)
                
                    Toggle("Tires Package (Cost: 2)", isOn: tiresPackageBinding).disabled(locked || remainingFunds < 2 && !tiresPackage)
                
                    Toggle("Accelerator Package (Cost: 3)", isOn: accelPackageBinding).disabled(locked || remainingFunds < 3 && !accelPackage)
                
                    Toggle("Everything Package  (Cost: 4)", isOn: allPackageBinding).disabled(locked || remainingFunds < 4 && !allPackage)
                }
            }
            }
            Text("Remaining Funds: \(remainingFunds)").foregroundColor(.red).baselineOffset(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
