import SwiftUI
import CoreMotion

class SensorsData: ObservableObject {
    private var motionManager = CMMotionManager()

    @Published var rotationRate: CMRotationRate = CMRotationRate(x: 0, y: 0, z: 0)
    @Published var acceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)

    var gyroData: (pitch: Double, roll: Double, yaw: Double) = (0, 0, 0)

    private var lastUpdate: Date? = nil

    // Kalman filter state variables
    private var x: [Double] = [0, 0, 0] // [pitch, roll, yaw]
    private var P: [[Double]] = [[1, 0, 0], [0, 1, 0], [0, 0, 1]] // Covariance
    private let Q: [[Double]] = [[0.001, 0, 0], [0, 0.001, 0], [0, 0, 0.001]] // Process noise covariance
    private let R: [[Double]] = [[0.01, 0, 0], [0, 0.01, 0], [0, 0, 0.01]] // Measurement noise covariance

    init() {
        startUpdates()
    }

    func startUpdates() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.01
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else {
                    if let error = error {
                        print("Gyro error: \(error.localizedDescription)")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.rotationRate = data.rotationRate
                    //self.updateKalmanFilter(gyro: data.rotationRate)
                }
            }
        } else {
            print("Gyroscope not available.")
        }

        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else {
                    if let error = error {
                        print("Accelerometer error: \(error.localizedDescription)")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.acceleration = data.acceleration
                    self.updateKalmanFilter(acc: data.acceleration)
                }
            }
        } else {
            print("Accelerometer not available.")
        }
    }

    func updateKalmanFilter(acc: CMAcceleration? = nil, gyro: CMRotationRate? = nil) {
        print("\n\n\n\n")
        // Calculate the time elapsed since the last update
        let now = Date()
        var deltaTime: TimeInterval = 0.01
        if let lastUpdate = self.lastUpdate {
            deltaTime = now.timeIntervalSince(lastUpdate)
        }
        self.lastUpdate = now

        // Prediction step using gyro data
        if let gyro = gyro {
            x[0] += gyro.x * deltaTime
            x[1] += gyro.y * deltaTime
            x[2] += gyro.z * deltaTime
        }
        var P_pred = P
        for i in 0..<3 {
            for j in 0..<3 {
                P_pred[i][j] += Q[i][j]
            }
        }

        // Update step using accelerometer data
        if let acc = acc {
            let z = [atan2(acc.y, acc.z), atan2(-acc.x, acc.z), atan2(acc.y, acc.x)]
            let y = [z[0] - x[0], z[1] - x[1], z[2] - x[2]]
            var S = [[Double]](repeating: [Double](repeating: 0, count: 3), count: 3)
            for i in 0..<3 {
                for j in 0..<3 {
                    S[i][j] = P_pred[i][j] + R[i][j]
                }
            }
            var K = [[Double]](repeating: [Double](repeating: 0, count: 3), count: 3)
            for i in 0..<3 {
                for j in 0..<3 {
                    K[i][j] = P_pred[i][j] / S[i][j]
                }
            }
            for i in 0..<3 {
                x[i] += K[i][i] * y[i]
            }
            for i in 0..<3 {
                for j in 0..<3 {
                    P[i][j] = (1 - K[i][i]) * P_pred[i][j]
                }
            }

            print("Accelerometer Data: \(acc)")
            print("Gyroscope Data: \(String(describing: gyro))")

            print("Predicted State (before update): \(x)")
            print("Predicted Covariance (before update): \(P_pred)")

            // Update state using Kalman filter
            print("Measured State: \(z)")
            print("Innovation (Residual): \(y)")
            print("Innovation Covariance: \(S)")
            print("Kalman Gain: \(K)")

            print("Updated State (after correction): \(x)")
            print("Updated Covariance (after correction): \(P)")
        }

        self.gyroData = (pitch: x[0], roll: x[1], yaw: x[2])

        // Print updated orientation data
        print("Pitch: \(x[0])")
        print("Roll: \(x[1])")
        print("Yaw: \(x[2])")
    }

    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
}
