//
//  CareerStatistics.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import Foundation

struct CareerStatistics {
    let courses: [Course]
    let honorValue: Double

    var completedCFU: Int {
        var totalCFU = 0

        for course in courses {
            if course.status == .completed {
                totalCFU += course.cfu
            }
        }

        return totalCFU
    }

    var weightedAverage: Double? {
        var totalCFU = 0
        var weightedSum = 0.0

        for course in courses {
            if course.status == .completed,
               let grade = course.grade {

                totalCFU += course.cfu

                var value = Double(grade)

                if grade == 30 && course.honor {
                    value = honorValue
                }

                weightedSum += value * Double(course.cfu)
            }
        }

        if totalCFU == 0 {
            return nil
        }

        return weightedSum / Double(totalCFU)
    }

    var graduationBase: Double {
        guard let average = weightedAverage else {
            return 0.0
        }

        let base = average / 30.0 * 110.0
        return min(base, 110)
    }
}
