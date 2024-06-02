//
//  TopView.swift
//  SwingDetect
//
//  Created by Jordan on 02/06/2024.
//

import SwiftUI

struct TopView: View {
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
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
                        .frame(width: width / (2.5 / 2) + 10, height: height * 0.13)
                        .background(.green)
                        .cornerRadius(10)
                    }
                    .frame(width: width, height: height * 0.13)
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
                        .frame(width: width / 2.5, height: height * 0.08)
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
                        .frame(width: width / 2.5, height: height * 0.08)
                        .background(.white)
                        .cornerRadius(10)
                        Spacer()
                    }
                    .frame(width: width, height: height * 0.1)
                }
                .frame(width: width, height: height * 0.25)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}
