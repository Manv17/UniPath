//
//  CareerStorage.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import Foundation

struct CareerStorage {

    private static var fileURL: URL? {
        let fileManager = FileManager.default

        guard let folder = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first else {
            return nil
        }

        return folder.appendingPathComponent("career.json")
    }

    static func save(_ career: Career) {
        guard let fileURL else {
            return
        }

        do {
            let folder = fileURL.deletingLastPathComponent()

            try FileManager.default.createDirectory(
                at: folder,
                withIntermediateDirectories: true
            )

            let data = try JSONEncoder().encode(career)

            try data.write(
                to: fileURL,
                options: .atomic
            )

            print("Carriera salvata")

        } catch {
            print("Errore nel salvataggio della carriera: \(error)")
        }
    }

    static func load() -> Career? {
        guard let fileURL else {
            return nil
        }

        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)

            let career = try JSONDecoder().decode(
                Career.self,
                from: data
            )

            print("Carriera caricata")

            return career

        } catch {
            print("Errore nel caricamento della carriera: \(error)")
            return nil
        }
    }

    static func delete() {
        guard let fileURL else {
            return
        }

        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("Errore nella cancellazione della carriera: \(error)")
        }
    }
}
