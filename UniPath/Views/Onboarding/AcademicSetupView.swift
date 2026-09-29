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
    
    @State private var showingUniversityPicker = false
    
    var body: some View {
        NavigationStack {
            Form{
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
                
                Picker("Corso di laurea", selection: $degreeType) {
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
