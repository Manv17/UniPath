//
//  CareerSetupView.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import SwiftUI

struct CareerSetupView: View {
    
    let onCareerSaved: (Career) -> Void
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var matricola = ""
    @State private var enrollmentYear = Calendar.current.component(.year, from: Date())
    @State private var degreeType: DegreeType = .bachelor
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Dati personali") {
                    TextField("Nome e cognome", text: $fullName)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Matricola", text: $matricola)
                        .keyboardType(.numberPad)
                }
                
                Section("Carriera") {
                    Picker(
                        "Anno di iscrizione",
                        selection: $enrollmentYear
                    ) {
                        let currentYear = Calendar.current.component(.year, from: Date())
                        let minYear = currentYear - 10
                        
                        ForEach(minYear...currentYear + 1, id: \.self) { year in
                            Text(String(year))
                                .tag(year)
                        }
                    }
                    
                    Picker("Tipo di laurea", selection: $degreeType) {
                        ForEach(DegreeType.allCases, id: \.self) { degree in
                            Text(degree.rawValue)
                                .tag(degree)
                        }
                    }
                }
            }
            .navigationTitle("Configura carriera")
            .toolbar {
                Button("Salva") {
                    saveCareer()
                }
                .buttonStyle(.glassProminent)
            }
        }
    }
    
    private func saveCareer() {
        let career = Career(
            fullName: fullName,
            email: email,
            matricola: matricola,
            enrollmentYear: enrollmentYear,
            degreeType: degreeType,
            courses: []
        )
        
        CareerStorage.save(career)
    }
}

#Preview {
    CareerSetupView { _ in }
}
