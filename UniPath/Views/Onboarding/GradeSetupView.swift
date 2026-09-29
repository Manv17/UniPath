//
//  GradeSetupView.swift
//  UniPath
//
//  Created by Manveer Singh on 29/09/2026.
//

import SwiftUI

struct GradeSetupView: View {
    
    @Binding var honorValue: Double
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section{
                    Picker("30L vale", selection: $honorValue) {
                        Text("30").tag(30.0)
                        Text("30,5").tag(30.5)
                        Text("31").tag(31.0)
                        Text("31,5").tag(31.5)
                        Text("32").tag(32.0)
                        Text("32,5").tag(32.5)
                        Text("33").tag(33.0)
                    }
                } header: {
                    Text("Valore della lode")
                } footer: {
                    Text("Indica il valore attribuito a un 30 e lode nel calcolo della media.")
                }
            }
            
            .navigationTitle("Lode")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
