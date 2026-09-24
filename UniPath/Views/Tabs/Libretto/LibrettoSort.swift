//
//  LibrettoSort.swift
//  UniPath
//
//  Created by Manveer Singh on 24/09/2026.
//

import Foundation

enum LibrettoSort: CaseIterable, Identifiable {

    case dateAscending
    case dateDescending
    case gradeAscending
    case gradeDescending
    case yearAscending
    case yearDescending

    var id: Self {
        self
    }

    var title: String {
        switch self {
        case .dateAscending:
            return "Data crescente"
        case .dateDescending:
            return "Data decrescente"
        case .gradeAscending:
            return "Voto crescente"
        case .gradeDescending:
            return "Voto decrescente"
        case .yearAscending:
            return "Anno crescente"
        case .yearDescending:
            return "Anno decrescente"
        }
    }
    
    var shortTitle: String {
        switch self {
        case .gradeAscending:
            return "Voto ↑"

        case .gradeDescending:
            return "Voto ↓"

        case .dateAscending:
            return "Data ↑"

        case .dateDescending:
            return "Data ↓"

        case .yearAscending:
            return "Anno ↑"

        case .yearDescending:
            return "Anno ↓"
        }
    }
}
