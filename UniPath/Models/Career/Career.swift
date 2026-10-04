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
    var university: University?
    var honorValue: Double
    var major: String
    
    init(
        fullName: String = "",
        email: String = "",
        matricola: String = "",
        university: University? = nil,
        major: String = "",
        enrollmentYear: Int = Calendar.current.component(.year, from: Date()),
        degreeType: DegreeType = .bachelor,
        courses: [Course] = [],
        honorValue: Double = 30.0
    ) {
        self.fullName = fullName
        self.email = email
        self.matricola = matricola
        self.university = university
        self.enrollmentYear = enrollmentYear
        self.degreeType = degreeType
        self.courses = courses
        self.honorValue = honorValue
        self.major = major
    }
    
    var duration: Int {
        switch degreeType {
        case .bachelor:
            return 3
        case .master:
            return 2
        case .singleCycle:
            return 5
        case .singleCycle6:
            return 6
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
        let calendar = Calendar.current
        let now = Date()

        var endComponents = DateComponents()
        endComponents.year = enrollmentYear + duration
        endComponents.month = 10
        endComponents.day = 1

        guard let academicCourseEnd = calendar.date(from: endComponents),
              let statusDeadline = calendar.date(
                byAdding: .month,
                value: 6,
                to: academicCourseEnd
              )
        else {
            return "In corso"
        }

        if now < statusDeadline {
            return "In corso"
        } else {
            return "Fuoricorso"
        }
    }
}
