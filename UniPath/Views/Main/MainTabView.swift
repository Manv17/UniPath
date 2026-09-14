//
//  MainTabView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Libretto", systemImage: "book.pages.fill") {
                LibrettoView()
            }
            
            Tab("Profilo", systemImage: "person.crop.circle.fill") {
                ProfileView()
            }
            
            Tab("Tessera", systemImage: "person.text.rectangle.fill", role: .search) {
                StudentIDView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
