//
//  ProfileView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var career: Career
    
    @State private var showingEditCareerSheet = false
    
    var body: some View {
        NavigationStack{
            
            Form{
                ProfileCard(name: career.fullName, matricola: career.matricola, mail: career.email)
                
                Section("Stato") {
                    
                    LabeledContent("Stato") {
                        Text(career.status)
                            .foregroundStyle(career.status == "In corso"
                                             ? .green : .red
                            )
                            .bold()
                    }
                    
                    LabeledContent("Anno"){
                        Text("\(career.currentAccademicYear)")
                    }
                }
                
                Section("Dati corso di laurea") {
                    LabeledContent("Corso di laurea"){
                        Text(career.degreeType.rawValue)
                    }
                    
                    LabeledContent(
                        "Anno immatricolazione",
                        value: "\(career.enrollmentYear)"
                    )
                }
                
                Button("Modifica carriera") {
                    showingEditCareerSheet = true
                }
            }
            
            .sheet(isPresented: $showingEditCareerSheet) {
                EditCareerView(career: $career)
            }
        }
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
    
    ProfileView(career: $career)
}
