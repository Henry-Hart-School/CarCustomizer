//
//  ContentView.swift
//  CarCustomizer
//
//  Created by Hart, Henry (AGDF) on 16/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
    
    //let accel_formatted = String(format: "%.2f", car.acceleration)
    var body: some View {
        Text(car.stringify())
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
