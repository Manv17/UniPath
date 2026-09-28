//
//  UniversityPickerView.swift
//  UniPath
//
//  Created by Manveer Singh on 29/09/2026.
//

import SwiftUI

struct UniversityPickerView: View {
    
    @Binding var selectedUniversity: University?
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    
    private var filteredUniversities: [University] {
        if searchText.isEmpty {
            return UniversityCatalog.all
        }
        
        return UniversityCatalog.all.filter { university in
            university.name.localizedCaseInsensitiveContains(searchText) ||
            university.shortName.localizedCaseInsensitiveContains(searchText) ||
            university.city.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                Button {
                    selectedUniversity = nil
                    dismiss()
                } label: {
                    HStack {
                        Text("Non impostata")
                        
                        Spacer()
                        
                        if selectedUniversity == nil {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .buttonStyle(.plain)
                .foregroundStyle(selectedUniversity == nil ? Color.accentColor : .primary)
                
                ForEach(filteredUniversities) { university in
                    Button {
                        selectedUniversity = university
                        dismiss()
                    } label: {
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(university.shortName)
                                    .foregroundStyle(selectedUniversity?.id == university.id ? Color.accentColor : .primary)
                                
                                Text("\(university.name) - \(university.city)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            if selectedUniversity?.id == university.id {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    
                }
            }
            .navigationTitle("Scegli la tua Università")
            .navigationBarTitleDisplayMode(.inline)
            
            .searchable(
                text: $searchText,
                prompt: "Cerca università"
            )
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(){
                        dismiss()
                    }label:{
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}
