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
            Text("Accelerometer Data")
                .font(.largeTitle)
                .padding()
            Text("X: \(motionManager.acceleration.x, specifier: "%.2f")")
            Text("Y: \(motionManager.acceleration.y, specifier: "%.2f")")
            Text("Z: \(motionManager.acceleration.z, specifier: "%.2f")")

            Text("Backswing Detected:" + (motionManager.isBackswingDetected ? "Yes" : "No"))
                .font(.title)
                .foregroundColor(motionManager.isBackswingDetected ? .green : .red)
                .padding()
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
