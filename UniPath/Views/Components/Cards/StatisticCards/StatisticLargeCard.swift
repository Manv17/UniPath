//
//  StatisticLargeCard.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/26.
//

import SwiftUI

struct StatisticLargeCard: View {
    
    var title: String
    var color: Color
    var value: Double
    var maxValue: Int
    var minValue: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            
            HStack(alignment: .bottom,spacing: 20) {
                ProgressRing(progress: value,
                             maxValue: Double(maxValue),
                             minValue: Double(minValue),
                             color: color,
                             size: 80,
                             lineWidth: 16)
                Text(String(format: "%.2f / %d", value, maxValue))
                    .font(.headline)
                    .fontWeight(.medium)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
        
        StatisticLargeCard(title: "Media ponderata", color: Color.blue, value: 25.00, maxValue: 30, minValue: 18)
            .padding(.horizontal, 16)
    }
}
