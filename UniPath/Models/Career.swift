//
//  Career.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import Foundation

struct Career: Codable {
    var fullName: String
    var email: String
    var matricola: String
    var enrollmentYear: Int
    var degreeType: DegreeType
    var courses: [Course]
    
    init(
        fullName: String = "",
        email: String = "",
        matricola: String = "",
        enrollmentYear: Int = Calendar.current.component(.year, from: Date()),
        degreeType: DegreeType = .bachelor,
        courses: [Course] = []
    ) {
        self.fullName = fullName
        self.email = email
        self.matricola = matricola
        self.enrollmentYear = enrollmentYear
        self.degreeType = degreeType
        self.courses = courses
    }
    
    var duration: Int {
        switch degreeType {
        case .bachelor:
            return 3
        case .master:
            return 2
        case .singleCycle:
            return 5
        }
    }
    
    private var academicYear: Int {
        let calendar = Calendar.current
        let now = Date()

        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)

        let academicYearStart: Int

        if month >= 10 {
            academicYearStart = year
        } else {
            academicYearStart = year - 1
        }

        return max(
            academicYearStart - enrollmentYear + 1,
            1
        )
    }
    
    var currentAccademicYear: Int {
        academicYear
    }

    var status: String {
        if academicYear <= duration {
            return "In corso"
        } else {
            return "Fuoricorso"
        }
    }
}
