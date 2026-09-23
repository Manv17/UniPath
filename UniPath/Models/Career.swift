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
}
