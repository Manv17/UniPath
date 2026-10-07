//
//  EditPersonalView.swift
//  UniPath
//
//  Created by Manveer Singh on 06/10/2026.
//

import SwiftUI

struct EditPersonalView: View {
    
    @Binding var career: Career
    
    @State private var editedName = ""
    @State private var editedEmail = ""
    @State private var editedMatricola = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form{
            
            Section{
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
            }
            
            Section {
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
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email universitaria")
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
            }
        }
        .navigationTitle("Dati personali")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("Salva"){
                    saveChanges()
                }
                .buttonStyle(.glassProminent)
                .disabled(
                    editedName
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .isEmpty
                )
            }
        }
        
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        editedName = career.fullName
        editedEmail = career.email
        editedMatricola = career.matricola
    }
    
    private func saveChanges() {
        career.fullName = editedName
        career.email = editedEmail
        career.matricola = editedMatricola
        
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
    
    EditPersonalView(career: $career)
}
