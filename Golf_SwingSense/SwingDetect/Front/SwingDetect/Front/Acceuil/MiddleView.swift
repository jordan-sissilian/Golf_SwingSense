//
//  MiddleView.swift
//  SwingDetect
//
//  Created by Jordan on 02/06/2024.
//

import SwiftUI

struct MiddleView: View {
    @Binding var showView: Int
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        VStack (spacing: 0) {
            VStack (spacing: 0) {
                HStack {
                    Text("Titre 🏌️⛳️")
                        .foregroundStyle(.white)
                        .font(.title3)
                    Spacer()
                }
                .frame(width: width, height: height * 0.04)
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
                    Spacer().frame(width: 20)
                }
                .frame(width: width, height: height * 0.16)
                HStack {
                    ZStack {
                        Button(action: {
                            // Action du bouton de gauche
                        }) {
                            Image("")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                        .frame(width: width * 0.43, height: height * 0.065)
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
                        .frame(width: width * 0.3, height: height * 0.065)
                        .background(Color(red: 49/255, green: 157/255, blue: 95/255))
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
                        .offset(x: width * 0.17)
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
                        .frame(width: width * 0.3, height: height * 0.065)
                        .background(.white)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
                    }
                    .padding(.trailing)
                }
                .frame(width: width, height: height * 0.1)
            }
            .frame(width: width, height: height * 0.32)
            .background(Color(red: 17/255, green: 18/255, blue: 20/255))
            BottomView(showView: $showView, width: width, height: height)
                            .frame(height: 60)
        }
        .frame(width: width, height: height * 0.4)
        .background(.green)
    }
}
