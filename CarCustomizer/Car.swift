//
//  Car.swift
//  CarCustomizer
//
//  Created by Hart, Henry (AGDF) on 16/01/2023.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    func stringify() -> String {
        return "Car Make: \(self.make)\nModel: \(self.model)\nTop Speed: \(self.topSpeed)mph\nAcceleration (0-60):\(String(format: "%.1f", self.acceleration))s\nHandling: \(self.handling)"
    }
}
