//
//  ContentView.swift
//  SwingDetect
//
//  Created by William Risal on 19/05/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var motionManager = SensorsData()

    var body: some View {
        VStack {
            VStack {
                Text("Gyro Data")
                    .font(.largeTitle)
                    .padding()
                Text("X: \(String(format: "%.1f", motionManager.rotationRate.x)), Y: \(String(format: "%.1f", motionManager.rotationRate.y)), Z: \(String(format: "%.1f", motionManager.rotationRate.z))")
                Text("pitch: \(motionManager.gyroData.pitch, specifier: "%.1f")")
                Text("yaw: \(motionManager.gyroData.roll, specifier: "%.1f")")
                Text("row: \(motionManager.gyroData.yaw, specifier: "%.1f")")
                Button("Reset") {
                    motionManager.gyroData = (0, 0, 0)
                }
            }

            VStack {
                Text("Accelerometer Data")
                    .font(.largeTitle)
                    .padding()
                let magnitude = sqrt(pow(motionManager.accelerometerData.x, 2) + pow(motionManager.accelerometerData.y, 2) + pow(motionManager.accelerometerData.z, 2))
                Text("X: \(String(format: "%.1f", motionManager.accelerometerData.x)), Y: \(String(format: "%.1f", motionManager.accelerometerData.y)), Z: \(String(format: "%.1f", motionManager.accelerometerData.z))")
                Text("Magnitude: \(String(format: "%.1f", magnitude)) g")
                Text("Speed: \(String(format: "%.1f", motionManager.accelerometerData.speed))")
            }

        }
        .padding()
        .onAppear(){
            motionManager.startUpdates()
        }
    }
}

#Preview {
    ContentView()
}
