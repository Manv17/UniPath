//
//  CourseSorter.swift
//  UniPath
//
//  Created by Manveer Singh on 24/09/2026.
//

import Foundation

struct CourseSorter {
    
    static func sort(courses: [Course], by sort: LibrettoSort) -> [Course] {
        
        switch sort {
        case .dateAscending:
            return courses.sorted {
                ($0.date ?? .distantFuture) <
                    ($1.date ?? .distantFuture)
            }
        case .dateDescending:
            return courses.sorted {
                ($0.date ?? .distantPast) >
                ($1.date ?? .distantPast)
            }
            
        case .gradeAscending:
            return courses.sorted {
                ($0.grade ?? 31) <
                    ($1.grade ?? 31)
            }
            
        case .gradeDescending:
            return courses.sorted {
                ($0.grade ?? 0) >
                ($1.grade ?? 0)
            }
            
        case .yearAscending:
            return courses.sorted {
                $0.year < $1.year
            }
            
        case .yearDescending:
            return courses.sorted {
                $0.year > $1.year
            }
        }
    }
}
