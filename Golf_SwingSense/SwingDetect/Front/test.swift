import SwiftUI
import CoreMotion

struct SensorData {
    var accelerometer: CMAccelerometerData?
    var gyroscope: CMGyroData?
    var magnetometer: CMMagnetometerData?
}

class SensorManager: ObservableObject {
    @Published var sensorData = SensorData()
    
    let motionManager = CMMotionManager()
    
    init() {
        startMotionUpdates()
    }
    
    func startMotionUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                guard let data = data else { return }
                self.sensorData.accelerometer = data
            }
        }
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: .main) { data, error in
                guard let data = data else { return }
                self.sensorData.gyroscope = data
            }
        }
        if motionManager.isMagnetometerAvailable {
            motionManager.magnetometerUpdateInterval = 0.1
            motionManager.startMagnetometerUpdates(to: .main) { data, error in
                guard let data = data else { return }
                self.sensorData.magnetometer = data
            }
        }
    }
}

struct test: View {
    @StateObject var sensorManager = SensorManager()
    
    var body: some View {
        VStack(spacing: 20) {
            ParallaxView(offsetX: CGFloat(sensorManager.sensorData.accelerometer?.acceleration.x ?? 0) * 10,
                         offsetY: CGFloat(sensorManager.sensorData.accelerometer?.acceleration.y ?? 0) * 10) {
                accelerometerView("Accéléromètre:", data: sensorManager.sensorData.accelerometer)
            }
            ParallaxView(offsetX: CGFloat(sensorManager.sensorData.gyroscope?.rotationRate.x ?? 0),
                         offsetY: CGFloat(sensorManager.sensorData.gyroscope?.rotationRate.y ?? 0)) {
                gyroscopeView("Gyroscope:", data: sensorManager.sensorData.gyroscope)
            }
            ParallaxView(offsetX: CGFloat(sensorManager.sensorData.magnetometer?.magneticField.x ?? 0) / 100,
                         offsetY: CGFloat(sensorManager.sensorData.magnetometer?.magneticField.y ?? 0) / 100) {
                magnetometerView("Magnétomètre:", data: sensorManager.sensorData.magnetometer)
            }
        }
        .padding()
    }
    
    func accelerometerView(_ title: String, data: CMAccelerometerData?) -> some View {
        let acceleration = data?.acceleration ?? CMAcceleration(x: 0, y: 0, z: 0)
        let colors: [Color] = [.red, .green, .blue]
        
        return VStack(spacing: 5) {
            Text(title)
                .font(.headline)
            
            ZStack {
                ForEach(0..<3) { index in
                    Rectangle()
                        .frame(width: 100 - CGFloat(index) * 20, height: 100 - CGFloat(index) * 20)
                        .foregroundColor(colors[index])
                        .offset(x: CGFloat(index) * (acceleration.x * 10), y: CGFloat(index) * (acceleration.y * 10))
                }
                
                VStack(spacing: 5) {
                    if let acceleration = data?.acceleration {
                        Text(String(format: "X: %.3f", acceleration.x))
                        Text(String(format: "Y: %.3f", acceleration.y))
                        Text(String(format: "Z: %.3f", acceleration.z))
                    } else {
                        Text("No data")
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
    
    func gyroscopeView(_ title: String, data: CMGyroData?) -> some View {
        let rotationRate = data?.rotationRate ?? CMRotationRate(x: 0, y: 0, z: 0)
        let colors: [Color] = [.orange, .purple, .yellow]
        
        return VStack(spacing: 5) {
            Text(title)
                .font(.headline)
            
            ZStack {
                ForEach(0..<3) { index in
                    Rectangle()
                        .frame(width: 100 - CGFloat(index) * 20, height: 100 - CGFloat(index) * 20)
                        .foregroundColor(colors[index])
                        .offset(x: CGFloat(index) * (rotationRate.x * 10), y: CGFloat(index) * (rotationRate.y * 10))
                }
                
                VStack(spacing: 5) {
                    if let rotationRate = data?.rotationRate {
                        Text(String(format: "X: %.3f", rotationRate.x))
                        Text(String(format: "Y: %.3f", rotationRate.y))
                        Text(String(format: "Z: %.3f", rotationRate.z))
                    } else {
                        Text("No data")
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
    
    func magnetometerView(_ title: String, data: CMMagnetometerData?) -> some View {
        let magneticField = data?.magneticField ?? CMMagneticField(x: 0, y: 0, z: 0)
        let colors: [Color] = [.pink, .cyan, .gray]
        
        return VStack(spacing: 5) {
            Text(title)
                .font(.headline)
            
            ZStack {
                ForEach(0..<3) { index in
                    Rectangle()
                        .frame(width: 100 - CGFloat(index) * 20, height: 100 - CGFloat(index) * 20)
                        .foregroundColor(colors[index])
                        .offset(x: CGFloat(index) * (magneticField.x * 10), y: CGFloat(index) * (magneticField.y * 10))
                }
                
                VStack(spacing: 5) {
                    if let magneticField = data?.magneticField {
                        Text(String(format: "X: %.3f", magneticField.x))
                        Text(String(format: "Y: %.3f", magneticField.y))
                        Text(String(format: "Z: %.3f", magneticField.z))
                    } else {
                        Text("No data")
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct ParallaxView<Content: View>: View {
    let offsetX: CGFloat
    let offsetY: CGFloat
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                content()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.offsetX, y: self.offsetY)
            }
        }
    }
}
