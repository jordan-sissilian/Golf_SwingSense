import SwiftUI

struct SwingView: View {
    @Binding var showView: Int

    @StateObject private var motion = SensorsData()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("backgroundSwing2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                VStack {
                    HStack {
                        Button(action: {
                            showView = 1
                        }) {
                            Image(systemName: "chevron.backward")
                                .imageScale(.large)
                                .foregroundStyle(.white)
                        }
                        .padding()
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                    VStack {
                        HStack {
                            VStack {
                                Text("Etape X")
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                Text("lorem ipsum")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                            }
                            .padding(.leading)
                            Spacer()
                            RoundedComponent(size: 50, min: -3, max: 3, value: motion.gyroData.pitch)
                                .padding(.trailing)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                        ZStack {
                            RoundedComponent(size: 170, min: -3, max: 3, value: motion.gyroData.roll)
                            Text("Lorem")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .offset(x: -80, y: 160)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                        HStack {
                            Spacer()
                            RoundedComponent(size: 50, min: -3, max: 2, value: motion.gyroData.pitch)
                            Spacer()
                            RoundedComponent(size: 50, min: -3, max: 2, value: motion.gyroData.yaw)
                            Spacer()
                            RoundedComponent(size: 50, min: -3, max: 2, value: motion.gyroData.pitch)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.8)
                    .padding()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear {
                motion.startUpdates()
            }
        }
    }
}


