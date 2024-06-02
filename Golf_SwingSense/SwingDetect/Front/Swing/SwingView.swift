import SwiftUI
import AVFoundation

struct SwingView: View {
    @Binding var showView: Int

    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color(red: 17/255, green: 18/255, blue: 20/255).opacity(0.9))
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
                        .frame(width: geometry.size.width * 0.25)
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
                            .frame(width: geometry.size.width * 0.7)
                                RoundedComponent(size: 50, min: -3, max: 3, value: 1)
                                    .padding(.trailing)
                                    .frame(width: geometry.size.width * 0.3)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                        ZStack {
                            ZStack () {
                                RoundedComponent(size: 170, min: -3, max: 3, value: 3)
                                Button(action: {
                                    generator.impactOccurred()

                                    if let path = Bundle.main.path(forResource: "Whoosh1", ofType: "wav") {
                                        let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                                        player?.play()
                                    }
                                }) {
                                    Image(systemName: "restart")
                                        .font(.system(size: 50))
                                        .foregroundStyle(.black.opacity(0.8))
                                }
                                .padding()
                                .frame(width: geometry.size.width * 0.25)
                            }
                            Text("BackSwing")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .offset(x: -80, y: 160)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                        HStack {
                            RoundedComponent(size: 50, min: -3, max: 2, value: -2)
                                .frame(width: geometry.size.width * 0.333)
                            RoundedComponent(size: 50, min: -3, max: 2, value: 0)
                                .frame(width: geometry.size.width * 0.333)
                            RoundedComponent(size: 50, min: -3, max: 2, value: 1)
                                .frame(width: geometry.size.width * 0.333)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.8)
                    .padding()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                    try AVAudioSession.sharedInstance().setActive(true)
                    print("La session audio est-elle activée : \(AVAudioSession.sharedInstance())")
                } catch {
                    print("Erreur lors de la configuration de la session audio : \(error)")
                }
            }
        }
    }
}


