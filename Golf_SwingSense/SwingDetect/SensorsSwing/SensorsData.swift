import SwiftUI
import CoreMotion

class SensorsData: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var acceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    @Published var rotationRate: CMRotationRate = CMRotationRate(x: 0, y: 0, z: 0)
    @Published var magneticField: CMMagneticField = CMMagneticField(x: 0, y: 0, z: 0)

    @Published var isBackswingDetected: Bool = false // Ajout de la propriété isBackswingDetected
    @Published var isPhoneUpsideDown: Bool = false // Ajout de la propriété isPhoneUpsideDown
    @Published var orientation: String = "Unknown" // Ajout de la propriété orientation

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
                    self.detectOrientation()
                }
            }
        }
        
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 1.0 / 60.0  // 60 Hz
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }
                DispatchQueue.main.async {
                    self.rotationRate = data.rotationRate
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
    
    private func detectOrientation() {
         let threshold: Double = 0.8
         
         if acceleration.z > threshold {
             print(acceleration.z, "Face Up")
         } else if acceleration.z < -threshold {
             print(acceleration.z, "Face Down")
         } else if acceleration.y > threshold {
             print(acceleration.z, "Standing on Bottom Edge")
         } else if acceleration.y < -threshold {
             print(acceleration.z, "Standing on Top Edge")
         } else if acceleration.x > threshold {
             print(acceleration.z, "Standing on Right Edge")
         } else if acceleration.x < -threshold {
             print(acceleration.z, "Standing on Left Edge")
         } else if acceleration.x > -threshold{
             print("position SWINGG")
         } else {
             print(acceleration.z, "Unknown")
         }
         
         // Check if phone is upside down
         isPhoneUpsideDown = acceleration.z < -threshold
     }
    
    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
}
