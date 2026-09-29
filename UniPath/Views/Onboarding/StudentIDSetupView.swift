//
//  StudentIDSetupView.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import SwiftUI

import PhotosUI

struct StudentIDSetupView: View {

    let onCompleted: () -> Void

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {

                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 250)
                    }

                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images
                    ) {
                        Label(
                            "Seleziona QR code",
                            systemImage: "photo"
                        )
                    }
                } header: {
                    Text("Tessera studente")
                } footer: {
                    Text(
                        "Puoi aggiungere il QR code della tua tessera studente ora oppure farlo più tardi dalle impostazioni del profilo."
                    )
                }
            }
            .navigationTitle("Tessera studente")
            .navigationBarTitleDisplayMode(.large)
            
            .onChange(of: selectedItem) { _, newItem in
                loadImage(from: newItem)
            }
        }
    }

    private func loadImage(from item: PhotosPickerItem?) {
        guard let item else {
            return
        }

        Task {
            do {
                if let data = try await item.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            } catch {
                print("Errore nel caricamento dell'immagine: \(error)")
            }
        }
    }

    private func saveStudentID() {
        guard let selectedImageData else {
            return
        }

        StudentIDStorage.save(selectedImageData)
        onCompleted()
    }
}

#Preview {
    StudentIDSetupView{}
}
