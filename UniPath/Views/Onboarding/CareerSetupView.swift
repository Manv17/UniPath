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
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nome e cognome")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Es: Marco Rossi", text: $fullName)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Email istituzionale", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Matricola")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Numero di matricola studente", text: $matricola)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section("Carriera") {
                    
                    Picker("Tipo di laurea", selection: $degreeType) {
                        ForEach(DegreeType.allCases, id: \.self) { degree in
                            Text(degree.rawValue)
                                .tag(degree)
                        }
                    }
                    
                    Picker(
                        "Anno di immatricolazione",
                        selection: $enrollmentYear
                    ) {
                        let currentYear = Calendar.current.component(.year, from: Date())
                        let minYear = currentYear - 10
                        
                        ForEach(minYear...currentYear + 1, id: \.self) { year in
                            Text(String(year))
                                .tag(year)
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
        onCareerSaved(career)
    }
}

#Preview {
    CareerSetupView { _ in }
}
