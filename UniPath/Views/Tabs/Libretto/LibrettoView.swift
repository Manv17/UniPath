//
//  LibrettoView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct LibrettoView: View {
    
    let career: Career
    
    @State private var selectedFilter: LibrettoFilter = .all
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    filterPicker
                    
                    if filteredCourses.isEmpty {
                        
                        ContentUnavailableView(
                            "Nessun corso",
                            systemImage: "books.vertical",
                            description: Text(emptyStateMessage)
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.top, 60)
                        
                    } else {
                        
                        ForEach(filteredCourses) { course in
                            CourseRow(course: course)
                        }
                    }
                }
                .padding()
            }
            .background(
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
            )
            .navigationTitle("Libretto")
            .toolbarTitleDisplayMode(.inline)
        }
    }
    
    private var filterPicker: some View {
        Picker(
            "Filtro",
            selection: $selectedFilter
        ) {
            ForEach(LibrettoFilter.allCases) { filter in
                Text(filter.title)
                    .tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .tint(.accentColor)
    }
    
    private var filteredCourses: [Course] {
        switch selectedFilter {
            
        case .all:
            return career.courses
            
        case .completed:
            return career.courses.filter { course in
                course.status == .completed
            }
            
        case .planned:
            return career.courses.filter { course in
                course.status == .planned
            }
            
        case .toDo:
            return career.courses.filter { course in
                course.status == .toDo
            }
        }
    }
    
    private var emptyStateMessage: String {
        switch selectedFilter {
            
        case .all:
            return "Non ci sono ancora corsi nel libretto"
            
        case .completed:
            return "Non ci sono corsi completati"
            
        case .planned:
            return "Non ci sono corsi pianificati"
            
        case .toDo:
            return "Non ci sono corsi da fare"
        }
    }
}

#Preview {
    LibrettoView(
        career: Career(
            fullName: "Mario Rossi",
            degreeType: .bachelor,
            courses: [
                Course(
                    name: "Analisi 1",
                    cfu: 9,
                    grade: 27,
                    status: .completed,
                    type: .graded,
                    semester: .first
                ),
                
                Course(
                    name: "Programmazione",
                    cfu: 12,
                    grade: 30,
                    status: .completed,
                    type: .graded,
                    semester: .first
                ),
                
                Course(
                    name: "Fisica",
                    cfu: 9,
                    grade: 24,
                    status: .completed,
                    type: .graded,
                    semester: .first
                ),
                
                Course(
                    name: "Analisi 2",
                    cfu: 8,
                    status: .planned,
                    type: .graded,
                    semester: .first
                ),
                
                Course(
                    name: "Reti di calcolatori",
                    cfu: 9,
                    status: .toDo,
                    type: .graded,
                    semester: .first
                ),
                
                Course(
                    name: "Inglese B2",
                    cfu: 3,
                    status: .completed,
                    type: .passFail,
                    semester: .first
                )
            ]
        )
    )
}
