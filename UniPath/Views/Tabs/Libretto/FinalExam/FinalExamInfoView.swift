//
//  FinalExamInfoView.swift
//  UniPath
//
//  Created by Manveer Singh on 05/10/2026.
//

import SwiftUI

struct FinalExamInfoView: View {
    
    let finalExam: FinalExam
    @Binding var career: Career
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingEditFinalExamSheet = false
    @State private var showingDeleteConfirmation = false
    
    private var currentFinalExam: FinalExam {
        career.finalExam ?? finalExam
    }
    
    private var formattedDate: String {
        guard let date = currentFinalExam.date else {
            return ""
        }
        
        return date.formatted(
            date: .numeric,
            time: .omitted
        )
    }
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Prova finale") {
                    
                    VStack(alignment: .leading) {
                        Text("CFU")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text("\(currentFinalExam.cfu)")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Punteggio massimo")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text("\(currentFinalExam.maxPoints)")
                    }
                }
                
                Section("Stato e valutazione") {
                    
                    VStack(alignment: .leading) {
                        Text("Stato")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text(
                            currentFinalExam.isCompleted
                            ? "Completata"
                            : "Da fare"
                        )
                    }
                    
                    if currentFinalExam.isCompleted {

                        VStack(alignment: .leading) {
                            Text("Data")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)

                            Text(formattedDate)
                        }

                        VStack(alignment: .leading) {
                            Text("Punti ottenuti")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)

                            Text("\(currentFinalExam.points)")
                        }
                    }
                }
            }
        }
        .navigationTitle("Prova finale (Tesi)")
        .toolbarTitleDisplayMode(.large)
        
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    showingEditFinalExamSheet = true
                } label: {
                    Label(
                        "Modifica",
                        systemImage: "pencil"
                    )
                }
                
                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        
        .sheet(isPresented: $showingEditFinalExamSheet) {
            EditFinalExamView(
                finalExam: currentFinalExam,
                career: $career
            )
        }
        
        .alert("Eliminare la prova finale?", isPresented: $showingDeleteConfirmation) {
            Button("Annulla", role: .cancel) { }
            
            Button("Elimina", role: .destructive) {
                career.finalExam = nil
                
                CareerStorage.save(career)
                
                dismiss()
            }
            
        } message: {
            Text("La prova finale verrà eliminata dalla tua carriera.")
        }
    }
}

#Preview {
    
    @Previewable @State var career = Career(
        fullName: "Mario Rossi",
        courses: [
            Course(
                name: "Analisi 1",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                date: Date(),
                grade: 27
            )
        ]
    )
    
    FinalExamInfoView(
        finalExam: FinalExam(
            cfu: 3,
            maxPoints: 3
        ),
        career: $career
    )
}
