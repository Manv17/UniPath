//
//  IDCard.swift
//  UniPath
//
//  Created by Manveer Singh on 02/10/2026.
//

import SwiftUI

struct IDCard: View {
    
    let career: Career
    let studentID: StudentID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 70){
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    
                    HStack(spacing: 12){
                        Image(systemName: "graduationcap.circle.fill")
                            .font(.title)
                        
                        Text(
                            career.university?.name
                            ?? "Tessera Universitaria"
                        )
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.bottom, 20)
                    
                    Divider()
                }
                .padding(.bottom, 30)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(career.fullName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    Text("Matricola: \(career.matricola)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(career.email)
//                        .fontWeight(.semibold)
                    
                    LabeledContent(
                        "Anno immatricolazione",
                        value: "\(career.enrollmentYear)"
                    )
//                    .fontWeight(.semibold)
                    .padding(.top, 10)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Spacer()
                
                if let uiImage = UIImage(
                    data: studentID.imageData
                ) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(10)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .frame(
            maxWidth: .infinity,
            minHeight: 570,
            alignment: .leading
        )
        .foregroundStyle(Color.white)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    MeshGradient(
                        width: 6,
                        height: 3,
                        points: [
                            [0.0, 0.0], [0.2, 0.0],
                            [0.4, 0.0], [0.6, 0.0],
                            [0.8 , 0.0], [1.0, 0.0], // Riga superiore
                            [0.0, 0.5], [0.2, 0.5], [0.4, 0.5],[0.6,0.5],[0.8, 0.5],[1.0, 0.5],  // Riga centrale
                            [0.0, 1.0], [0.2, 1.0], [0.4, 1.0], [0.6, 1.0],[0.8, 1.0],[1.0, 1.0]  // Riga inferiore
                        ],
                        colors: [
                            .idBlue, .idBlue, .idBlue, .idBlue, .cyan, .cyan,
                            .idBlue, .idBlue, .idBlue, .idBlue, .idBlue, .idBlue,
                            .cyan, .cyan, .idBlue, .idBlue, .idBlue, .cyan
                        ]
                    )
                )
                .shadow(
                    color: .black.opacity(0.4),
                    radius: 40,
                    x: 0,
                    y: 8
                )
        )
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
        email: "340887@studenti.unimore.it",
        matricola: "191273",
        university: university,
        enrollmentYear: 2023,
        degreeType: .bachelor,
        honorValue: 31
    )
    
    let studentID = StudentID(
        imageData: UIImage(
            systemName: "qrcode"
        )?.pngData() ?? Data()
    )
    
    IDCard(
        career: career,
        studentID: studentID
    )
    .padding()
}
