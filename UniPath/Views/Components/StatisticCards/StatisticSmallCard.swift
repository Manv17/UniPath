//
//  StatisticSmallCard.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/26.
//

import SwiftUI

struct StatisticSmallCard: View {
    var title: String
    var color: Color
    var value: Int
    var maxValue: Int
    var minValue: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 20) {
                ProgressRing(
                    progress: Double(value),
                    maxValue: Double(maxValue),
                    minValue: Double(minValue),
                    color: color,
                    size: 40,
                    lineWidth: 10
                )

                Text("\(value) / \(maxValue)")
                    .fontWeight(.medium)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .topLeading)
        .contentShape(Rectangle())
        .padding(20)
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

        HStack(spacing: 12) {
            StatisticSmallCard(title: "Crediti", color: .teal, value: 120, maxValue: 180, minValue: 0)
            StatisticSmallCard(title: "Base di laurea", color: Color(.indigo), value: 91, maxValue: 110, minValue: 66)
        }
        .padding(.horizontal, 16)
    }
}
