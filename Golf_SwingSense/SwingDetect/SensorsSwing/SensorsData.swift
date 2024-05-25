import SwiftUI
import CoreMotion

class SensorsData: ObservableObject {
    private var motionManager = CMMotionManager()

    @Published var rotationRate: CMRotationRate = CMRotationRate(x: 0, y: 0, z: 0)
    @Published var acceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    @Published var magneticField: CMMagneticField = CMMagneticField(x: 0, y: 0, z: 0)

    var posData: (pitch: Double, roll: Double, yaw: Double) = (0, 0, 0)
    var gyroData: (pitch: Double, roll: Double, yaw: Double) = (0, 0, 0)
    var accelerometerData: (x: Double, y: Double, z: Double, speed: Double) = (0, 0, 0, 0)
    var magnetometerData: (x: Double, y: Double, z: Double) = (0, 0, 0)

    init() {
        startUpdates()
    }

    func startUpdates() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }
                DispatchQueue.main.async {
                    // Intégration des vitesses angulaires pour obtenir la rotation
                    let pitch = self.gyroData.pitch + data.rotationRate.x
                    let roll = self.gyroData.roll + data.rotationRate.y
                    let yaw = self.gyroData.yaw + data.rotationRate.z

                    // Stockage des valeurs dans gyroData
                    self.rotationRate = data.rotationRate
                    self.gyroData = (pitch: pitch, roll: roll, yaw: yaw)
                }
            }
        }

        if motionManager.isAccelerometerAvailable {
                   motionManager.accelerometerUpdateInterval = 0.01
                   motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                       guard let self = self, let data = data else { return }
                       DispatchQueue.main.async {
                           self.acceleration = data.acceleration
                           
                           self.accelerometerData = (x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z, 0)

                           let accelerationThreshold = 1.0
                           if abs(data.acceleration.x) > accelerationThreshold ||
                              abs(data.acceleration.y) > accelerationThreshold ||
                              abs(data.acceleration.z) > accelerationThreshold {

                               let magnitude = sqrt(pow(data.acceleration.x, 2) + pow(data.acceleration.y, 2) + pow(data.acceleration.z, 2))
                               self.accelerometerData.speed = (magnitude * 9.81) - 9.81 // Convertir en m/s²

                           } else {
                               self.accelerometerData.speed = 0
                           }

                           self.printDat()
                       }
                   }
               }

        if motionManager.isMagnetometerAvailable {
            motionManager.magnetometerUpdateInterval = 0.05
            motionManager.startMagnetometerUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }
                DispatchQueue.main.async {
                    self.magneticField = data.magneticField
                }
            }
        }
    }
    
    func printDat() {
        print(String(format: "%.2f", self.accelerometerData.speed))
    }

    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopMagnetometerUpdates()
    }

    func hasGyroMovedSignificantly(previousRotationRate: CMRotationRate) -> Bool {
        let threshold = 0.01
        let deltaX = abs(rotationRate.x - previousRotationRate.x)
        let deltaY = abs(rotationRate.y - previousRotationRate.y)
        let deltaZ = abs(rotationRate.z - previousRotationRate.z)
        return deltaX > threshold || deltaY > threshold || deltaZ > threshold
    }
    
}

