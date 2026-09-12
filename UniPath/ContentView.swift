//
//  ContentView.swift
//  UniPath
//
//  Created by Manveer Singh on 05/09/2026.
//

import SwiftUI

struct ContentView: View {

    @State private var career: Career?
    @State private var hasStudentID = false

    var body: some View {
        Group {
            if career == nil {

                CareerSetupView { newCareer in
                    career = newCareer
                }

            } else if !hasStudentID {

                StudentIDSetupView {
                    hasStudentID = true
                }

            } else {

                Text("UniPath")

            }
        }
        .onAppear {
            career = CareerStorage.load()
            hasStudentID = StudentIDStorage.load() != nil
        }
    }
}

#Preview {
    ContentView()
}
