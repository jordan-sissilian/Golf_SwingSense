import SwiftUI
import CoreMotion

class SensorsData: ObservableObject {
    private var motionManager = CMMotionManager()

    @Published var rotationRate: CMRotationRate = CMRotationRate(x: 0, y: 0, z: 0)
    @Published var acceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    @Published var magneticField: CMMagneticField = CMMagneticField(x: 0, y: 0, z: 0)

    var posData: (x: Double, y: Double, z: Double) = (0, 0, 0)
    var gyroData: (pitch: Double, roll: Double, yaw: Double) = (0, 0, 0)
    var accelerometerData: (x: Double, y: Double, z: Double, speed: (speedX: Double, speedY: Double, speedZ: Double)) = (0, 0, 0, (0, 0, 0))
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

                           self.accelerometerData = (x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z, (0, 0, 0))

                           let accelerationThreshold = 1.0
                           if abs(data.acceleration.x) > accelerationThreshold ||
                              abs(data.acceleration.y) > accelerationThreshold ||
                              abs(data.acceleration.z) > accelerationThreshold {

                               // Calculez la magnitude de l'accélération
                               let magnitude = sqrt(pow(data.acceleration.x, 2) + pow(data.acceleration.y, 2) + pow(data.acceleration.z, 2))

                               // Vérifiez si la magnitude est non nulle pour éviter une division par zéro
                               guard magnitude != 0 else {
                                   return
                               }

                               // Calculez les composantes de vitesse dans les directions X, Y et Z en multipliant chaque composante d'accélération par la magnitude
                               let speedX = data.acceleration.x * magnitude
                               let speedY = data.acceleration.y * magnitude
                               let speedZ = data.acceleration.z * magnitude

                               // Mettez à jour les valeurs de speedX, speedY et speedZ dans accelerometerData.speed
                               self.accelerometerData.speed = (speedX: speedX, speedY: speedY, speedZ: speedZ)

                           } else {
                               self.accelerometerData.speed = (0, 0, 0)
                           }
                           self.estimatePosition()
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
                    self.magnetometerData = (self.magneticField.x, self.magneticField.y, self.magneticField.z)
                }
            }
        }
    }
    

    func estimatePosition() {
        // Estimer l'orientation à partir des données du gyroscope
        let pitch = gyroData.pitch
        let roll = gyroData.roll
        let yaw = gyroData.yaw

        // Intégrer la vitesse pour obtenir la position
        let positionX = accelerometerData.x
        let positionY = accelerometerData.y
        let positionZ = accelerometerData.z
        
        // Transformer les changements de position relatifs en position absolue dans l'espace en fonction de l'orientation
        let absolutePositionX = positionX * cos(roll) * cos(pitch) + positionY * (cos(roll) * sin(pitch) * sin(yaw) - sin(roll) * cos(yaw)) + positionZ * (cos(roll) * sin(pitch) * cos(yaw) + sin(roll) * sin(yaw))
        let absolutePositionY = positionX * sin(roll) * cos(pitch) + positionY * (sin(roll) * sin(pitch) * sin(yaw) + cos(roll) * cos(yaw)) + positionZ * (sin(roll) * sin(pitch) * cos(yaw) - cos(roll) * sin(yaw))
        let absolutePositionZ = positionX * -sin(pitch) + positionY * cos(pitch) * sin(yaw) + positionZ * cos(pitch) * cos(yaw)
        
        self.posData = (absolutePositionX, absolutePositionY, absolutePositionZ)
    }
    
    func printDat() {
        print("\(String(format: "%.1f", posData.x)) \(String(format: "%.1f", posData.y)) \(String(format: "%.1f", posData.z))")
    }

    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopMagnetometerUpdates()
    }
    
}

