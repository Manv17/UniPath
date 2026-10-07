//
//  EditStudentIDView.swift
//  UniPath
//
//  Created by Manveer Singh on 06/10/2026.
//

import SwiftUI
import PhotosUI

struct EditStudentIDView: View {
   
    @State private var selectedImageData: Data?
    @State private var selectedItem: PhotosPickerItem?
   
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form{
            Section("Codice tessera"){
                if let imageData = selectedImageData,
                   let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                    
                    Button(role: .destructive){
                        selectedImageData = nil
                        StudentIDStorage.delete()
                    } label: {
                        Label(
                            "Elimina QR code",
                            systemImage: "trash"
                        )
                        .foregroundStyle(.red)
                    }
                }
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images
                ) {
                    Label(
                        selectedImageData == nil
                        ? "Seleziona QR code"
                        : "Sostituisci QR code",
                        systemImage: "photo"
                    )
                }
            }
        }
        .navigationTitle("Codice tessera studente")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("Salva"){
                    saveChanges()
                }
                .buttonStyle(.glassProminent)
            }
        }
        
        .onAppear {
            loadData()
        }
        
        .onChange(of: selectedItem) { _, newItem in
            loadImage(from: newItem)
        }
    }
    
    private func loadData() {
        selectedImageData = StudentIDStorage.load()
    }
    
    private func saveChanges() {        
        if let selectedImageData {
            StudentIDStorage.save(selectedImageData)
        }
        
        dismiss()
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
                print("Errore nel caricamento del QR code: \(error)")
            }
        }
    }
}

#Preview {    
    EditStudentIDView()
}
