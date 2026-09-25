//
//  EditCareerView.swift
//  UniPath
//
//  Created by Manveer Singh on 26/09/2026.
//

import SwiftUI

struct EditCareerView: View {
    
    @Binding var career: Career
    
    @State private var editedName = ""
    @State private var editedEmail = ""
    @State private var editedMatricola = ""
    @State private var editedEnrollmentYear = 2026
    @State private var editedDegreeType: DegreeType = .bachelor
    
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
                    
                    Picker(
                        "Tipo di laurea",
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
                }
            }
            
            .onAppear {
                loadData()
            }
        }
    }
    
    private func loadData() {
        editedName = career.fullName
        editedEmail = career.email
        editedMatricola = career.matricola
        editedEnrollmentYear = career.enrollmentYear
        editedDegreeType = career.degreeType
    }
    
    private func saveChanges() {
        career.fullName = editedName
        career.email = editedEmail
        career.matricola = editedMatricola
        career.enrollmentYear = editedEnrollmentYear
        career.degreeType = editedDegreeType
        
        CareerStorage.save(career)
        
        dismiss()
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
