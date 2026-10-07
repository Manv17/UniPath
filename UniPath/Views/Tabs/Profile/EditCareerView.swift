//
//  EditCareerView.swift
//  UniPath
//
//  Created by Manveer Singh on 26/09/2026.
//

import SwiftUI

struct EditCareerView: View {
    
    @Binding var career: Career
    let onDeleteCareer: () -> Void
    
    @State private var showingDeleteConfirmation = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink("Dati personali") {
                        EditPersonalView(career: $career)
                    }
                    
                    NavigationLink("Corso di laurea e lode"){
                        EditAcademicView(career: $career)
                    }
                    
                    NavigationLink("Codice tessera studente"){
                        EditStudentIDView()
                    }
                }
                
                Section {
                    // altro
                }
                
                Section {
                    Button(role: .destructive) {
                        showingDeleteConfirmation = true
                    } label: {
                        Label(
                            "Elimina carriera",
                            systemImage: "trash"
                        )
                        .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Impostazioni")
            .navigationBarTitleDisplayMode(.inline)
            
            .alert("Eliminare la carriera?", isPresented: $showingDeleteConfirmation) {
                Button("Annulla", role: .cancel) { }
                
                Button("Elimina", role: .destructive) {
                    deleteCareer()
                }
            } message: {
                Text(
                    "Tutti i dati della carriera verranno eliminati definitivamente.\n Questa azione non può essere annullata."
                )
            }
        }
    }
    
    private func deleteCareer(){
        CareerStorage.delete()
        StudentIDStorage.delete()
        
        onDeleteCareer()
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
        career: $career, onDeleteCareer: {}
    )
}
