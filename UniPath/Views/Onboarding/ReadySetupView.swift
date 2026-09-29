//
//  ReadySetupView.swift
//  UniPath
//
//  Created by Manveer Singh on 30/09/2026.
//

import SwiftUI

struct ReadySetupView: View {

    let name: String

    var body: some View {
        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.tint)

            VStack(spacing: 8) {

                Text("Tutto pronto!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("La tua carriera è stata configurata.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            if !name.isEmpty {
                Text("Benvenuto, \(name).")
                    .font(.headline)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ReadySetupView(
        name: "Manveer"
    )
}
