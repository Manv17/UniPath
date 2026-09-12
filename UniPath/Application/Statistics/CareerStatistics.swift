//
//  CareerStatistics.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import Foundation

struct CareerStatistics {
    let courses: [Course]

    var completedCFU: Int {
        courses
            .filter { $0.grade != nil }
            .reduce(0) { $0 + $1.cfu }
    }

    var weightedAverage: Double? {
        let completedCourses = courses.filter { $0.grade != nil }

        let totalCFU = completedCourses.reduce(0) { $0 + $1.cfu }

        guard totalCFU > 0 else {
            return nil
        }

        let weightedSum = completedCourses.reduce(0.0) { partialResult, course in
            partialResult + Double(course.grade ?? 0) * Double(course.cfu)
        }

        return weightedSum / Double(totalCFU)
    }

    var graduationBase: Double? {
        guard let weightedAverage else {
            return nil
        }

        return weightedAverage / 30.0 * 110.0
    }
}
