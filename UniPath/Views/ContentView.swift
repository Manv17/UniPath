//
//  ContentView.swift
//  UniPath
//
//  Created by Manveer Singh on 05/09/2026.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false
    
    @State private var career: Career?
    
    var body: some View {
        
        Group {
            if !hasSeenWelcome {
                
                WelcomeView {
                    hasSeenWelcome = true
                }
                
            } else if career == nil {
                
                CareerSetupView { newCareer in
                    career = newCareer
                }
                
            } else {
                
                MainTabView(career: career!,
                            onDeleteCareer: {career = nil; hasSeenWelcome=false}
                )
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        career = CareerStorage.load()
    }
}

#Preview {
    ContentView()
}
