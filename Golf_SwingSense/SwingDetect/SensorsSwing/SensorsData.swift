import SwiftUI
import CoreMotion

class SensorsData: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var acceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    @Published var rotationRate: CMRotationRate = CMRotationRate(x: 0, y: 0, z: 0)
    @Published var magneticField: CMMagneticField = CMMagneticField(x: 0, y: 0, z: 0)

    @Published var isBackswingDetected: Bool = false // Ajout de la propriété isBackswingDetected
    @Published var isPhoneUpsideDown: Bool = false // Ajout de la propriété isPhoneUpsideDown

    init() {
        startUpdates()
    }

    func startUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }
                DispatchQueue.main.async {
                    self.acceleration = data.acceleration
                    self.checkBackswing()
                    self.checkOrientation()
                }
            }
        }
        
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 1.0 / 60.0  // 60 Hz
            motionManager.startGyroUpdates(to: .main) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.rotationRate = data.rotationRate
                    }
                }
            }
        }
    }
    
    private func checkBackswing() {
        // Calculate the magnitude of the acceleration vector
        let magnitude = sqrt(self.acceleration.x * self.acceleration.x + self.acceleration.y * self.acceleration.y + self.acceleration.z * self.acceleration.z)
        // Check if magnitude is within the defined thresholds
        let magnitudeInG = magnitude / 9.81 // 9.81 m/s² ≈ 1 g

        if magnitudeInG >= 0.5 && magnitudeInG <= 1.0 {
            isBackswingDetected = true
            print("SWINGGGGG")
        } else {
            isBackswingDetected = false
        }
    }
    
    private func checkOrientation() {
        let threshold: Double = 25.0 // Ajustez ce seuil selon vos besoins
        if abs(magneticField.z) > threshold {
            isPhoneUpsideDown = true
            print(magneticField.z)
            print("Téléphone à l'envers")
        } else {
            isPhoneUpsideDown = false
            print(magneticField.z)

            print("Téléphone orienté normalement")
        }
    }
    
    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
}
