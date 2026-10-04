//
//  EditCareerView.swift
//  UniPath
//
//  Created by Manveer Singh on 26/09/2026.
//

import SwiftUI
import PhotosUI

struct EditCareerView: View {
    
    @Binding var career: Career
    
    @State private var editedName = ""
    @State private var editedEmail = ""
    @State private var editedMatricola = ""
    @State private var editedEnrollmentYear = 2026
    @State private var editedDegreeType: DegreeType = .bachelor
    @State private var editedUniversity: University?
    @State private var selectedImageData: Data?
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var showingUniversityPicker = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Dati personali") {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nome e cognome")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField(
                            "Nome e cognome",
                            text: $editedName
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField(
                            "Email",
                            text: $editedEmail
                        )
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Matricola")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField(
                            "Matricola",
                            text: $editedMatricola
                        )
                    }
                }
                
                Section("Carriera") {
                    
                    Button {
                        showingUniversityPicker = true
                    } label: {
                        HStack {
                            Text("Università")
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Text(editedUniversity?.shortName ?? "Non impostata")
                                .foregroundStyle(.secondary)
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Picker(
                        "Corso di laurea",
                        selection: $editedDegreeType
                    ) {
                        ForEach(DegreeType.allCases) { degreeType in
                            Text(degreeType.rawValue)
                                .tag(degreeType)
                        }
                    }
                    
                    Picker(
                        "Anno immatricolazione",
                        selection: $editedEnrollmentYear
                    ) {
                        
                        let currentYear = Calendar.current.component(
                            .year,
                            from: Date()
                        )
                        
                        let minYear = currentYear - 10
                        
                        ForEach(
                            minYear...currentYear + 1,
                            id: \.self
                        ) { year in
                            Text(String(year))
                                .tag(year)
                        }
                    }
                }
                
                Section("Codice tessera"){
                    if let imageData = selectedImageData,
                       let uiImage = UIImage(data: imageData) {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                        
                        Button(
                            "Rimuovi QR code",
                            systemImage: "trash",
                            role: .destructive
                        ) {
                            selectedImageData = nil
                            StudentIDStorage.delete()
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
            .navigationTitle("Modifica carriera")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button("Salva") {
                        saveChanges()
                    }
                    .disabled(
                        editedName
                            .trimmingCharacters(in: .whitespaces)
                            .isEmpty
                    )
                    .buttonStyle(.glassProminent)
                }
            }
            
            .sheet(isPresented: $showingUniversityPicker) {
                UniversityPickerView(
                    selectedUniversity: $editedUniversity
                )
            }
            
            .onAppear {
                loadData()
            }
            
            .onChange(of: selectedItem) { _, newItem in
                loadImage(from: newItem)
            }
        }
    }
    
    private func loadData() {
        editedName = career.fullName
        editedEmail = career.email
        editedMatricola = career.matricola
        editedEnrollmentYear = career.enrollmentYear
        editedDegreeType = career.degreeType
        editedUniversity = career.university
        
        selectedImageData = StudentIDStorage.load()
    }
    
    private func saveChanges() {
        career.fullName = editedName
        career.email = editedEmail
        career.matricola = editedMatricola
        career.enrollmentYear = editedEnrollmentYear
        career.degreeType = editedDegreeType
        career.university = editedUniversity
        
        CareerStorage.save(career)
        
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
    @Previewable @State var career = Career(
        fullName: "Mario Rossi",
        email: "mario.rossi@studenti.unimore.it",
        matricola: "123456",
        enrollmentYear: 2023,
        degreeType: .bachelor
    )
    
    EditCareerView(
        career: $career
    )
}
