//
//  DegreeType.swift
//  UniPath
//
//  Created by Manveer Singh on 05/09/2026.
//

import Foundation

enum DegreeType: String, CaseIterable, Codable, Identifiable {
    case bachelor = "Triennale"
    case master = "Magistrale"
    case singleCycle = "Ciclo Unico"
    
    var id: Self { self }
    
    var defaultTotalCFU: Int {
        switch self {
        case .bachelor:
            return 180
        case .master:
            return 120
        case .singleCycle:
            return 300
        }
    }
}
