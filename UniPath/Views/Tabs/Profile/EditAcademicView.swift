//
//  EditAcademicView.swift
//  UniPath
//
//  Created by Manveer Singh on 06/10/2026.
//

import SwiftUI

struct EditAcademicView: View {
    
    @Binding var career: Career
    
    @State private var editedEnrollmentYear = 2026
    @State private var editedDegreeType: DegreeType = .bachelor
    @State private var editedUniversity: University?
    @State private var editedMajor = ""
    @State private var editedHonorValue = 30.0
    
    @State private var showingUniversityPicker = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            
            Section{
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
            }
            
            Section {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Corso di laurea")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                    
                    TextField(
                        "Es: Scienze Biologiche",
                        text: $editedMajor
                    )
                }
                
                Picker(
                    "Tipologia laurea",
                    selection: $editedDegreeType
                ) {
                    ForEach(DegreeType.allCases) { degreeType in
                        Text(degreeType.rawValue)
                            .tag(degreeType)
                    }
                }
            }
            
            Section{
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
            
            Section{
                Picker("30L vale", selection: $editedHonorValue) {
                    Text("30").tag(30.0)
                    Text("30,5").tag(30.5)
                    Text("31").tag(31.0)
                    Text("31,5").tag(31.5)
                    Text("32").tag(32.0)
                    Text("32,5").tag(32.5)
                    Text("33").tag(33.0)
                }
            } header: {
                Text("Valore della lode")
            } footer: {
                Text("Indica il valore attribuito a un 30 e lode nel calcolo della media.")
            }
        }
        .navigationTitle("Corso di laurea e lode")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            
            ToolbarItem(
                placement: .confirmationAction
            ) {
                Button("Salva") {
                    saveChanges()
                }
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
    }
    
    private func loadData() {
        editedEnrollmentYear = career.enrollmentYear
        editedDegreeType = career.degreeType
        editedUniversity = career.university
        editedMajor = career.major
        editedHonorValue = career.honorValue
    }
    
    private func saveChanges() {
        career.enrollmentYear = editedEnrollmentYear
        career.degreeType = editedDegreeType
        career.university = editedUniversity
        career.major = editedMajor
        career.honorValue = editedHonorValue
        
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
    
    EditAcademicView(career: $career)
}
