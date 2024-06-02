//
//  BottomViewView.swift
//  SwingDetect
//
//  Created by Jordan on 02/06/2024.
//

import SwiftUI

struct BottomView: View {
    @Binding var showView: Int
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        HStack {
            Button(action: {
                showView = 3
            }) {
                Image(systemName: "star.bubble.fill")
                    .imageScale(.large)
                    .foregroundStyle(.black)
            }
            .padding(.leading)
            .padding(.top)
            
            Spacer()
            
            Button(action: {
                showView = 2
            }) {
                Text("Let's Swing")
                    .foregroundStyle(.white)
            }
            .frame(width: width * 0.4, height: height * 0.065)
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
        .frame(width: width, height: height * 0.08)
        .background(.white)
    }
}
