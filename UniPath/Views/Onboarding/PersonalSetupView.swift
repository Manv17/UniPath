//
//  PersonalSetupView.swift
//  UniPath
//
//  Created by Manveer Singh on 29/09/2026.
//

import SwiftUI

struct PersonalSetupView: View {
    
    @Binding var fullName: String
    @Binding var email: String
    @Binding var matricola: String
    
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nome e cognome")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Es: Marco Rossi", text: $fullName)
                            .keyboardType(.alphabet)
                    }
                }
                
                Section{
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email universitaria")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Es: nome @studenti.universita.it", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Matricola")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Es: 123456", text: $matricola)
                            .keyboardType(.numberPad)
                    }
                } footer:{
                    Text("Controlla i dati nel sito della tua università.")
                }
            }
            .navigationTitle("Dati personali")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
