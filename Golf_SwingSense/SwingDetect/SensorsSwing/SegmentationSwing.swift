//
//  SegmentationSwing.swift
//  SwingDetect
//
//  Created by William Risal on 19/05/2024.
//

import Foundation
import CoreMotion
import Combine

class SegmentationSwing: ObservableObject {
    @Published var orientation: String = ""
    @Published var isBackswingDetected: Bool = false
    @Published var BackSwingIsEnd = false

    private var sensorsData: SensorsData
    private var cancellables = Set<AnyCancellable>()



    init(sensorsData: SensorsData) {
       self.sensorsData = sensorsData
       
     /*   self.sensorsData.$acceleration.sink { [weak self] _ in
            self?.detectOrientation()
        }.store(in: &cancellables)
*/
        self.sensorsData.$magneticField.sink { [weak self] _ in
            self?.detectEndSwing()
        }.store(in: &cancellables)
        
    }

    func detectOrientation() {
        let X = sensorsData.accelerometerData.speed.speedX
        let Y = sensorsData.accelerometerData.speed.speedY
        let lowerThreshold: Double = 0.2
        //let Z = sensorsData.accelerometerData.speed.speedZ
        
        if X < -lowerThreshold && Y > lowerThreshold {
            orientation = "Position BackSWINGG"
            print(X, Y, "Position SWINGG")
        } else {
            if(orientation != "Unknown"){
                orientation = "Unknown"
                print("Orientation détectée: Unknown")
            }
        }
    }

    private func detectEndSwing() {
        let magnitude = sqrt(pow(sensorsData.accelerometerData.x, 2) + pow(sensorsData.accelerometerData.y, 2) + pow(sensorsData.accelerometerData.z, 2))
        let magnitudeInG = magnitude / 9.81
        print(magnitudeInG)
        
        if magnitudeInG >= 0.5 && magnitudeInG <= 1.0 {
            isBackswingDetected = true
            print("SWINGGGGG")
        } 

        
        if (magnitudeInG < 0.5 && isBackswingDetected == true ){
            BackSwingIsEnd = true
            print(BackSwingIsEnd)
        }

    }
}
