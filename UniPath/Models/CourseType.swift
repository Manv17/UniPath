//
//  CourseType.swift
//  UniPath
//
//  Created by Manveer Singh on 23/09/2026.
//

enum CourseType: String, CaseIterable, Identifiable, Equatable, Codable {
    case graded = "Corso"
    case passFail = "Idoneità"
    
    var id : String { rawValue }
}
