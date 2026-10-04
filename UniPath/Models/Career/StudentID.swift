//
//  StudentID.swift
//  UniPath
//
//  Created by Manveer Singh on 02/10/2026.
//

import Foundation

struct StudentID: Identifiable, Codable, Hashable {

    let id: UUID
    var imageData: Data

    init(
        id: UUID = UUID(),
        imageData: Data
    ) {
        self.id = id
        self.imageData = imageData
    }
}
