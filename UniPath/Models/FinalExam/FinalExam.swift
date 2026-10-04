//
//  FinalExam.swift
//  UniPath
//
//  Created by Manveer Singh on 04/10/2026.
//

import Foundation

struct FinalExam: Codable, Hashable {
    var cfu: Int
    var points: Int
    var maxPoints: Int
    var isCompleted: Bool
    var date: Date?

    init(
        cfu: Int,
        points: Int = 0,
        maxPoints: Int,
        isCompleted: Bool = false,
        date: Date? = nil
    ) {
        self.cfu = cfu
        self.points = points
        self.maxPoints = maxPoints
        self.isCompleted = isCompleted
        self.date = date
    }
}
