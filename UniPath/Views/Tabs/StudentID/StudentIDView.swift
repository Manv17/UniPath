//
//  StudentIDView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct StudentIDView: View {
    
    @Binding var career: Career
    @State private var studentID: StudentID?
    
    @State private var showingEditCareer = false
    
    private var canShowStudentID: Bool {
        !career.fullName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !career.matricola.trimmingCharacters(in: .whitespaces).isEmpty &&
        !career.email.trimmingCharacters(in: .whitespaces).isEmpty &&
        studentID != nil
    }
    
    var body: some View {
        NavigationStack{
            
            if canShowStudentID, let studentID {
                IDCard(career: career, studentID: studentID)
                    .padding(.horizontal, 20)
            }
            else {
                VStack(spacing: 12){
                    
                    Text("Tessera non disponibile")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Inserisci Nome, matricola e QR code dalle impostazioni della tua carriera per vedere la tua tessera studente.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 40)
                    
                    Button("Vai alle impostazioni carriera") {
                        showingEditCareer = true
                    }
                    .buttonStyle(.glassProminent)
                    .controlSize(.large)
                }
            }
        }
        .navigationTitle("Tessera studente")
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear{
            loadStudentID()
        }
        
        .sheet(
            isPresented: $showingEditCareer,
            onDismiss: {
                loadStudentID()
            }
        ) {
            EditCareerView(career: $career)
        }
    }
    
    private func loadStudentID() {
        if let imageData = StudentIDStorage.load() {
            studentID = StudentID(
                imageData: imageData
            )
        } else {
            studentID = nil
        }
    }
}

#Preview {
    let university = University(
        id: "unimore",
        name: "Università degli Studi di Modena e Reggio Emilia",
        shortName: "UNIMORE",
        city: "Modena"
    )
    
    let career = Career(
        fullName: "Manveer Singh",
        email: "mail@mail.com",
        matricola: "191273",
        university: university,
        enrollmentYear: 2023,
        degreeType: .bachelor,
        honorValue: 31
    )
    
    let previewImageData =
    UIImage(systemName: "person.crop.square")?
        .pngData() ?? Data()
    
    let studentID = StudentID(
        imageData: previewImageData
    )
    
    IDCard(
        career: career,
        studentID: studentID
    )
    .padding()
}
