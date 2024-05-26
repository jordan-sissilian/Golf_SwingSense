//
//  RoundedComponant.swift
//  SwingDetect
//
//  Created by Jordan on 26/05/2024.
//

import SwiftUI

struct RoundedComponent: View {
    var size: CGFloat
    var min: CGFloat
    var max: CGFloat
    var value: CGFloat

    var body: some View {
        let scaleFactor = (value - min) / (max - min)
        let color = Color(red: Double(scaleFactor), green: Double(1.0 - scaleFactor), blue: 0.0)

        return ZStack {
            Circle()
                .fill(color.opacity(0.7))
                .frame(width: size + (size * scaleFactor), height: size + (size * scaleFactor))

            Circle()
                .fill(Color.white)
                .frame(width: size, height: size)
        }
    }
}
