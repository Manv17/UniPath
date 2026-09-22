//
//  HomeView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct HomeView: View {

    let career: Career

    var body: some View {

        let statistics = CareerStatistics(courses: career.courses)

        NavigationStack {
            ScrollView {

                VStack(spacing: 16) {

                    StatisticLargeCard(
                        title: "Media ponderata",
                        color: .blue,
                        value: statistics.weightedAverage ?? 0,
                        maxValue: 30,
                        minValue: 18
                    )

                    HStack(spacing: 12) {

                        StatisticSmallCard(
                            title: "CFU",
                            color: .teal,
                            value: statistics.completedCFU,
                            maxValue: career.degreeType.defaultTotalCFU,
                            minValue: 0
                        )

                        StatisticSmallCard(
                            title: "Base di laurea",
                            color: .indigo,
                            value: Int(statistics.graduationBase),
                            maxValue: 110,
                            minValue: 66
                        )
                    }
                }
                .padding()
            }
            .background(
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
            )
            .navigationTitle("Home")
        }
    }
}

#Preview {
    MainTabView(
        career: Career(
            fullName: "Mario Rossi"
        )
    )
}
