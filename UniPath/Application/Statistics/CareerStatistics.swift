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
            if course.status == .completed, let grade = course.grade {
                totalCFU += course.cfu
                weightedSum += Double(grade * course.cfu)
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

        return average / 30.0 * 110.0
    }
}
