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
        
        let seuil: Double = 0.8
        let seuilInferieur: Double = 0.2
    
        print("\n\n\n\n")
        print("Début de la détection de l'orientation")
        print("Valeurs de l'accélération - x: \(String(format: "%.4f", acceleration.x)), y: \(String(format: "%.4f", acceleration.y)), z: \(String(format: "%.4f", acceleration.z))")
        print("Seuils - seuil: \(String(format: "%.2f", seuil)), seuilInferieur: \(String(format: "%.2f", seuilInferieur))")
        
        if acceleration.z > seuil {
            orientation = "Face vers le haut"
            print("Condition: l'accélération z est supérieure au seuil")
            print("Orientation détectée: \(orientation)")
        } else if acceleration.z < -seuil {
            orientation = "Face vers le bas"
            print("Condition: l'accélération z est inférieure au seuil négatif")
            print("Orientation détectée: \(orientation)")
        } else if acceleration.y > seuil {
            orientation = "En équilibre sur le bord inférieur"
            print("Condition: l'accélération y est supérieure au seuil")
            print("Orientation détectée: \(orientation)")
        } else if acceleration.y < -seuil {
            orientation = "En équilibre sur le bord supérieur"
            print("Condition: l'accélération y est inférieure au seuil négatif")
            print("Orientation détectée: \(orientation)")
        } else if acceleration.x > seuil {
            orientation = "En équilibre sur le bord droit"
            print("Condition: l'accélération x est supérieure au seuil")
            print("Orientation détectée: \(orientation)")
        } else if acceleration.x < -seuil {
            orientation = "En équilibre sur le bord gauche"
            print("Condition: l'accélération x est inférieure au seuil négatif")
            print("Orientation détectée: \(orientation)")
        } else if acceleration.x < -seuilInferieur && acceleration.y > seuilInferieur {
            orientation = "Position SWINGG"
            print("Condition: l'accélération x est inférieure au seuil négatif et l'accélération y est supérieure au seuil inférieur")
            print("Orientation détectée: \(orientation)")
        } else {
            orientation = "Inconnue"
            print("Aucune des conditions précédentes n'a été remplie")
            print("Orientation détectée: \(orientation)")
        }
        
        isPhoneUpsideDown = acceleration.z < -seuil
        print("Le téléphone est-il retourné: \(isPhoneUpsideDown ? "oui" : "non")")
    }
    
    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
}
