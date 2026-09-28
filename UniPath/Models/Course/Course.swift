//
//  Course.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import Foundation

struct Course: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var cfu: Int
    var type: CourseType
    var year: Int
    var semester: CourseSemester
    var status: CourseStatus
    var date: Date?
    var grade: Int?

    init(
        id: UUID = UUID(),
        name: String,
        cfu: Int,
        type: CourseType,
        year: Int,
        semester: CourseSemester,
        status: CourseStatus = .toDo,
        date: Date? = nil,
        grade: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.cfu = cfu
        self.type = type
        self.year = year
        self.semester = semester
        self.status = status
        self.date = date
        self.grade = grade
    }
}
