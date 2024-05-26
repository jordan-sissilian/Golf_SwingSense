import SwiftUI

struct ContentView: View {
    @StateObject private var motionManager = SensorsData()

    var body: some View {
        VStack() {
            AcceuilView()
        }
        .onAppear() {
            motionManager.startUpdates()
        }
    }
}
