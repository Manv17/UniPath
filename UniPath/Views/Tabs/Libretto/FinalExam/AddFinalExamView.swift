//
//  AddFinalExamView.swift
//  UniPath
//
//  Created by Manveer Singh on 04/10/2026.
//

import SwiftUI

struct AddFinalExamView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var career: Career
    
    @State private var cfu = 0
    @State private var maxPoints = 0
    @State private var points = 0
    
    @State private var isCompleted = false
    @State private var date = Date()
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Prova finale") {
                    
                    Picker("CFU", selection: $cfu) {
                        ForEach(1...15, id: \.self) { value in
                            Text("\(value)")
                                .tag(value)
                        }
                    }
                    
                    Picker("Punteggio massimo", selection: $maxPoints) {
                        ForEach(1...15, id: \.self) { value in
                            Text("\(value)")
                                .tag(value)
                        }
                    }
                }
                
                Section("Stato") {
                    
                    Picker(
                        "Stato",
                        selection: $isCompleted
                    ) {
                        Text("Da fare")
                            .tag(false)
                        
                        Text("Completata")
                            .tag(true)
                    }
                    
                    if isCompleted {
                        
                        DatePicker(
                            "Data",
                            selection: $date,
                            displayedComponents: .date
                        )
                        
                        Picker("Punti ottenuti", selection: $points) {
                            ForEach(0...maxPoints, id: \.self) { value in
                                Text("\(value)")
                                    .tag(value)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Aggiungi prova finale")
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aggiungi") {
                        addFinalExam()
                    }
                    .disabled(!canAdd)
                    .buttonStyle(.glassProminent)
                }
            }
        }
    }
    
    private var canAdd: Bool {
        
        if cfu <= 0 {
            return false
        }
        
        if maxPoints <= 0 {
            return false
        }
        
        if isCompleted && points > maxPoints {
            return false
        }
        
        if isCompleted && points < 0 {
            return false
        }
        
        return true
    }
    
    private func addFinalExam() {
        
        var finalExam = FinalExam(
            cfu: cfu,
            points: isCompleted ? points : 0,
            maxPoints: maxPoints
        )
        
        finalExam.isCompleted = isCompleted
        
        if isCompleted {
            finalExam.date = date
        } else {
            finalExam.date = nil
        }
        
        career.finalExam = finalExam
        
        CareerStorage.save(career)
        
        dismiss()
    }
}
