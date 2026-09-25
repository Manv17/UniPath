//
//  MainTabView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct MainTabView: View {

    @State var career: Career

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView(career: career)
            }
            
            Tab("Libretto", systemImage: "book.pages.fill") {
                LibrettoView(career: $career)
            }
            
            Tab("Profilo", systemImage: "person.crop.circle.fill") {
                ProfileView(career: $career)
            }
            
            Tab("Tessera", systemImage: "person.text.rectangle.fill", role: .search) {
                StudentIDView()
            }
        }
    }
}

#Preview {
    MainTabView(
        career: Career(
            fullName: "Mario Rossi"
        )
    )
}
