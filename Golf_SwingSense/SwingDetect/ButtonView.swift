import SwiftUI
import Combine

struct ButtonView: View {
    @StateObject private var sensorsData = SensorsData()
    @StateObject private var segmentationSwing: SegmentationSwing

    init() {
        let sensorsData = SensorsData()
        _segmentationSwing = StateObject(wrappedValue: SegmentationSwing(sensorsData: sensorsData))
    }

    var body: some View {
        VStack {
            Button("Start Detection") {
                sensorsData.startUpdates()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Text("Orientation: \(segmentationSwing.orientation)")
            Text("Backswing Detected: \(segmentationSwing.isBackswingDetected ? "Yes" : "No")")
        }

    }

    private var cancellables = Set<AnyCancellable>()
}

#Preview {
    ButtonView()
}
