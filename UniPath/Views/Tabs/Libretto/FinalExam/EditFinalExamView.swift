//
//  EditFinalExamView.swift
//  UniPath
//
//  Created by Manveer Singh on 05/10/2026.
//

import SwiftUI

struct EditFinalExamView: View {

    @Environment(\.dismiss) private var dismiss

    @Binding var career: Career

    @State private var cfu: Int
    @State private var maxPoints: Int
    @State private var points: Int

    @State private var isCompleted: Bool
    @State private var date: Date

    init(
        finalExam: FinalExam,
        career: Binding<Career>
    ) {
        self._career = career

        _cfu = State(
            initialValue: finalExam.cfu
        )

        _maxPoints = State(
            initialValue: finalExam.maxPoints
        )

        _points = State(
            initialValue: finalExam.points
        )

        _isCompleted = State(
            initialValue: finalExam.isCompleted
        )

        _date = State(
            initialValue: finalExam.date ?? Date()
        )
    }

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

                    Picker(
                        "Punteggio massimo",
                        selection: $maxPoints
                    ) {
                        ForEach(1...15, id: \.self) { value in
                            Text("\(value)")
                                .tag(value)
                        }
                    }
                    .onChange(of: maxPoints) { _, newValue in
                        if points > newValue {
                            points = newValue
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

                        Picker(
                            "Punti ottenuti",
                            selection: $points
                        ) {
                            ForEach(0...maxPoints, id: \.self) { value in
                                Text("\(value)")
                                    .tag(value)
                            }
                        }

                        DatePicker(
                            "Data",
                            selection: $date,
                            displayedComponents: .date
                        )
                    }
                }
            }
            .navigationTitle("Modifica prova finale")
            .toolbarTitleDisplayMode(.large)
            
            .toolbar {

                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }

                ToolbarItem(
                    placement: .confirmationAction
                ) {
                    Button("Salva") {
                        saveChanges()
                    }
                    .buttonStyle(.glassProminent)
                }
            }
        }
    }

    private func saveChanges() {

        var updatedFinalExam = FinalExam(
            cfu: cfu,
            points: isCompleted ? points : 0,
            maxPoints: maxPoints
        )

        updatedFinalExam.isCompleted = isCompleted

        if isCompleted {
            updatedFinalExam.date = date
        } else {
            updatedFinalExam.date = nil
        }

        career.finalExam = updatedFinalExam

        CareerStorage.save(career)

        dismiss()
    }
}
