//
//  StudentIDStorage.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import Foundation

struct StudentIDStorage {

    private static var fileURL: URL? {
        let fileManager = FileManager.default

        guard let folder = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first else {
            return nil
        }

        return folder.appendingPathComponent("studentID.jpg")
    }

    static func save(_ data: Data) {
        guard let fileURL else {
            return
        }

        do {
            let folder = fileURL.deletingLastPathComponent()

            try FileManager.default.createDirectory(
                at: folder,
                withIntermediateDirectories: true
            )

            try data.write(
                to: fileURL,
                options: .atomic
            )

        } catch {
            print("Errore nel salvataggio della tessera: \(error)")
        }
    }

    static func load() -> Data? {
        guard let fileURL else {
            return nil
        }

        return try? Data(contentsOf: fileURL)
    }

    static func delete() {
        guard let fileURL else {
            return
        }

        try? FileManager.default.removeItem(at: fileURL)
    }
}
