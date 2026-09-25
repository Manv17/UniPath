//
//  ProgressRing.swift
//  UniPath
//
//  Created by Manveer Singh on 28/03/26.
//

import SwiftUI

struct ProgressRing: View {
    
    var progress: Double
    var maxValue: Double
    var minValue : Double
    var color: Color
    var size: CGFloat
    var lineWidth: CGFloat
    
    private var normalizedProgress: Double {
        guard maxValue > minValue else { return 0 }
        
        let value = (progress - minValue) / (maxValue - minValue)
        
        return min(max(value, 0), 1)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(color.opacity(0.1)),
                    lineWidth: lineWidth
                )
            
            Circle()
                .trim(from: 0, to: normalizedProgress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.6), value: normalizedProgress)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    ProgressRing(
        progress: 72,
        maxValue: 30,
        minValue: 18,
        color: .blue,
        size: 50,
        lineWidth: 8
    )
    .padding()
}
