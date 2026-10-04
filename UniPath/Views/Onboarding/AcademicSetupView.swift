//
//  AccademicSetup.swift
//  UniPath
//
//  Created by Manveer Singh on 29/09/2026.
//

import SwiftUI

struct AcademicSetupView: View {
    
    @Binding var university: University?
    @Binding var enrollmentYear: Int
    @Binding var degreeType: DegreeType
    @Binding var major: String
    
    @State private var showingUniversityPicker = false
    
    var body: some View {
        NavigationStack {
            Form{
                Section {
                    Button {
                        showingUniversityPicker = true
                    } label: {
                        HStack {
                            Text("Università")
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Text(university?.shortName ?? "Non impostata")
                                .foregroundStyle(.secondary)
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                Section {
                    Picker("Tipologia laurea", selection: $degreeType) {
                        ForEach(DegreeType.allCases, id: \.self) { degree in
                            Text(degree.rawValue)
                                .tag(degree)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Corso di laurea")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        TextField(
                            "Es: Scienze Biologiche",
                            text: $major
                        )
                    }
                }

                Section {
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
                } footer: {
                    HStack{
                        Image(systemName: "info.circle")
                        
                        Text("Potrai cambiare queste informazioni in qualsiasi momento nel tuo profilo.")
                    }
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Carriera universitaria")
            .navigationBarTitleDisplayMode(.large)
            
            
            .sheet(isPresented: $showingUniversityPicker) {
                UniversityPickerView(
                    selectedUniversity: $university
                )
            }
        }
    }
}
