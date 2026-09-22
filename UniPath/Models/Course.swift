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
    var grade: Int?
    var date: Date?
    var status: CourseStatus
    var type: CourseType
    var semester: CourseSemester

    init(
        id: UUID = UUID(),
        name: String,
        cfu: Int,
        grade: Int? = nil,
        date: Date? = nil,
        status: CourseStatus = .toDo,
        type: CourseType,
        semester: CourseSemester
    ) {
        self.id = id
        self.name = name
        self.cfu = cfu
        self.grade = grade
        self.date = date
        self.status = status
        self.type = type
        self.semester = semester
    }
}
