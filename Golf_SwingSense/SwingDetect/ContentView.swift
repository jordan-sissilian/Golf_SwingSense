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
            HStack {
                VStack {
                    Text("Gyro")
                        .font(.title)
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
                    Text("Accelerometer")
                        .font(.title)
                        .padding()
                    let magnitude = sqrt(pow(motionManager.accelerometerData.x, 2) + pow(motionManager.accelerometerData.y, 2) + pow(motionManager.accelerometerData.z, 2))
                    Text("X: \(String(format: "%.1f", motionManager.accelerometerData.x)), Y: \(String(format: "%.1f", motionManager.accelerometerData.y)), Z: \(String(format: "%.1f", motionManager.accelerometerData.z))")
                    Text("Magnitude: \(String(format: "%.1f", magnitude)) g")
                    VStack {
                        Text("Speed X: \(String(format: "%.1f", motionManager.accelerometerData.speed.speedX))")
                        Text("Speed Y: \(String(format: "%.1f", motionManager.accelerometerData.speed.speedY))")
                        Text("Speed Z: \(String(format: "%.1f", motionManager.accelerometerData.speed.speedZ))")
                    }

                }
            }
            HStack {
                VStack {
                    Text("Magnetormeter")
                        .font(.title)
                        .padding()
                    Text("X: \(String(format: "%.1f", motionManager.magnetometerData.x)), Y: \(String(format: "%.1f", motionManager.magnetometerData.y)), Z: \(String(format: "%.1f", motionManager.magnetometerData.z))")
                }
            }
            ButtonView()
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
