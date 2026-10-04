//
//  FinalExamRow.swift
//  UniPath
//
//  Created by Manveer Singh on 04/10/2026.
//

import SwiftUI

struct FinalExamRow: View {
    
    let finalExam: FinalExam
    @Binding var career: Career
    
    @State private var showingEditFinalExamSheet = false
    @State private var showingDeleteConfirmation = false
    
    private var formattedDate: String {
        guard let date = finalExam.date else { return "" }
        return date.formatted(date: .numeric, time: .omitted)
    }
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Prova finale (Tesi)")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                HStack {
                    Text("\(finalExam.cfu) CFU")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("•")
                        .foregroundStyle(.tertiary)
                    
                    Text(finalExam.isCompleted ? "Completata" : "Da fare")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            if finalExam.isCompleted {
                VStack(alignment: .trailing, spacing: 8) {

                    Text("\(finalExam.points)/\(finalExam.maxPoints)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)

                    Text(formattedDate)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
        )
        
        .contextMenu {
            Button("Modifica", systemImage: "pencil") {
                showingEditFinalExamSheet = true
            }
            
            Button("Elimina", systemImage: "trash", role: .destructive) {
                showingDeleteConfirmation = true
            }
        }
        
        .sheet(isPresented: $showingEditFinalExamSheet) {
            EditFinalExamView(finalExam: finalExam, career: $career)
        }
        
        .alert("Eliminare la prova finale?", isPresented: $showingDeleteConfirmation) {
            Button("Annulla", role: .cancel) { }
            
            Button("Elimina", role: .destructive) {
                career.finalExam = nil
                
                CareerStorage.save(career)
            }
            
        } message: {
            Text("La prova finale verrà eliminata dalla tua carriera.")
        }
    }
}

//#Preview {
//    FinalExamRow(finalExam: FinalExam(cfu: 3, maxPoints: 3))
//}
