//
//  Card-Profile.swift
//  UniPath
//
//  Created by Manveer Singh on 20/08/2026.
//

import SwiftUI

struct ProfileCard: View {
    
    var name: String
    var matricola: String
    var mail: String
    
    @State private var showMatricolaPopover = false
    @State private var showMailPopover = false
    
    var body: some View {
        Section {
            VStack(alignment: .center, spacing: 12) {
                
                Image(systemName: "person.crop.circle")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(matricola.isEmpty ? "Imposta matricola" : matricola)
                    .font(.title2)
                    .fontWeight(.bold)
                    .onTapGesture {
                        if !matricola.isEmpty {
                            showMatricolaPopover = true
                        }
                    }
                    .popover(isPresented: $showMatricolaPopover) {
                        Button {
                            UIPasteboard.general.string = matricola
                            showMatricolaPopover = false
                        } label: {
                            Label("Copia matricola", systemImage: "doc.on.doc")
                        }
                        .padding()
                        .presentationCompactAdaptation(.popover)
                        .buttonStyle(.plain)
                    }
                
                Text(mail.isEmpty ? "Imposta mail istituzionale" : mail)
                    .font(.subheadline)
                    .onTapGesture {
                        if !mail.isEmpty {
                            showMailPopover = true
                        }
                    }
                    .popover(isPresented: $showMailPopover) {
                        Button {
                            UIPasteboard.general.string = mail
                            showMailPopover = false
                        } label: {
                            Label("Copia email", systemImage: "doc.on.doc")
                        }
                        .padding()
                        .presentationCompactAdaptation(.popover)
                        .buttonStyle(.plain)
                    }
                

            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        
    }
}

#Preview {
    ProfileCard(name: "", matricola: "", mail: "")
}
