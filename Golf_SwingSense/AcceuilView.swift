import SwiftUI

struct AcceuilView: View {

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    Image("backgroundHome")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        VStack {
                            HStack {
                                ZStack {
                                    Image("backgroundTopHome")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .edgesIgnoringSafeArea(.all)
                                    VStack {
                                        Text("")
                                            .foregroundStyle(.white)
                                    }
                                }
                                .frame(width: geometry.size.width / (2.5 / 2) + 10, height: geometry.size.height * 0.13)
                                .background(.green)
                                .cornerRadius(10)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.13)
                            HStack {
                                Spacer()
                                Button(action: {
                                    // Action à exécuter lors du clic sur le VStack
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black.opacity(1), lineWidth: 0.8)
                                        VStack {
                                            Text("")
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width / 2.5, height: geometry.size.height * 0.08)
                                .background(.white)
                                .cornerRadius(10)
                                Button(action: {
                                    // Action à exécuter lors du clic sur le VStack
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black.opacity(1), lineWidth: 0.8)
                                        VStack {
                                            Text("")
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width / 2.5, height: geometry.size.height * 0.08)
                                .background(.white)
                                .cornerRadius(10)
                                Spacer()
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.25)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
                VStack (spacing: 0) {
                    VStack (spacing: 0) {
                        HStack {
                            Text("Titre 🏌️⛳️")
                                .foregroundStyle(.white)
                                .font(.title3)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.04)
                        .padding(.top)
                        HStack {
                            Spacer()
                            VStack {
                                Text("lorem ipsum")
                                    .foregroundStyle(.white)
                                Text("lorem ipsum")
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            VStack {
                                Text("lorem ipsum")
                                    .foregroundStyle(.white)
                                Text("lorem ipsum")
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.16)
                        HStack {
                            ZStack {
                                Button(action: {
                                    // Action du bouton de gauche
                                }) {
                                    Image("")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                }
                                .frame(width: geometry.size.width * 0.43, height: geometry.size.height * 0.065)
                                .background(Color(red: 33/255, green: 101/255, blue: 63/255))
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
                                
                                Button(action: {
                                    // Action du bouton de droite
                                }) {
                                    Image("")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                }
                                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.065)
                                .background(Color(red: 49/255, green: 157/255, blue: 95/255))
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
                                .offset(x: geometry.size.width * 0.17)
                            }
                            .padding(.leading)
                            Spacer()
                            VStack {
                                Button(action: {
                                    // Action du bouton
                                }) {
                                    Text("")
                                        .foregroundStyle(.black)
                                }
                                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.065)
                                .background(.white)
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
                            }
                            .padding(.trailing)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.32)
                    .background(Color(red: 17/255, green: 18/255, blue: 20/255))
                    HStack {
                        Button(action: {
                            // Action du bouton
                        }) {
                            Image(systemName: "star.bubble.fill")
                                .imageScale(.large)
                                .foregroundStyle(.black)
                        }
                        .padding(.leading)
                        .padding(.top)
                        Spacer()
                        Button(action: {
                            // Action du bouton
                        }) {
                            Text("Let's Swing")
                                .foregroundStyle(.white)
                        }
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.065)
                        .background(Color(red: 49/255, green: 157/255, blue: 95/255))
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
                        .padding(.top)
                        Spacer()
                        Button(action: {
                            // Action du bouton
                        }) {
                            Image(systemName: "figure.golf")
                                .imageScale(.large)
                                .foregroundStyle(.black)
                        }
                        .padding(.trailing)
                        .padding(.top)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.08)
                    .background(.white)
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                .background(.green)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

