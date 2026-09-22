//
//  LibrettoFilter.swift
//  UniPath
//
//  Created by Manveer Singh on 23/09/2026.
//

import Foundation

enum LibrettoFilter: CaseIterable, Identifiable {
    case all
    case completed
    case planned
    case toDo

    var id: Self { self }

    var title: String {
        switch self {
        case .all:
            return "Tutti"
        case .completed:
            return "Completati"
        case .planned:
            return "Pianificati"
        case .toDo:
            return "Da fare"
        }
    }
}
