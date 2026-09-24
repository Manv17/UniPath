//
//  LibrettoView.swift
//  UniPath
//
//  Created by Manveer Singh on 14/09/2026.
//

import SwiftUI

struct LibrettoView: View {
    
    @Binding var career: Career
    
    @State private var selectedFilter: LibrettoFilter = .all
    @State private var selectedSort: LibrettoSort = .dateDescending
    
    @State private var showingAddCourseSheet = false
    @State private var newCourseType: CourseType = .graded
    
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
                        
                        ForEach(sortedCourses) { course in
                            NavigationLink {
                                CourseInfoView(course: course, career: $career)
                            } label: {
                                CourseRow(course: course)
                            }
                            .buttonStyle(.plain)
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
            
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        
                        Text("Ordina corsi")
                        
                        Menu("Voto") {
                            
                            Button {
                                selectedSort = .gradeAscending
                            } label: {
                                if selectedSort == .gradeAscending {
                                    Label(
                                        "Crescente",
                                        systemImage: "checkmark"
                                    )
                                } else {
                                    Text("Crescente")
                                }
                            }
                            
                            Button {
                                selectedSort = .gradeDescending
                            } label: {
                                if selectedSort == .gradeDescending {
                                    Label(
                                        "Decrescente",
                                        systemImage: "checkmark"
                                    )
                                } else {
                                    Text("Decrescente")
                                }
                            }
                        }
                        
                        Menu("Data") {
                            
                            Button {
                                selectedSort = .dateAscending
                            } label: {
                                if selectedSort == .dateAscending {
                                    Label(
                                        "Crescente",
                                        systemImage: "checkmark"
                                    )
                                } else {
                                    Text("Crescente")
                                }
                            }
                            
                            Button {
                                selectedSort = .dateDescending
                            } label: {
                                if selectedSort == .dateDescending {
                                    Label(
                                        "Decrescente",
                                        systemImage: "checkmark"
                                    )
                                } else {
                                    Text("Decrescente")
                                }
                            }
                        }
                        
                        Menu("Anno") {
                            
                            Button {
                                selectedSort = .yearAscending
                            } label: {
                                if selectedSort == .yearAscending {
                                    Label(
                                        "Crescente",
                                        systemImage: "checkmark"
                                    )
                                } else {
                                    Text("Crescente")
                                }
                            }
                            
                            Button {
                                selectedSort = .yearDescending
                            } label: {
                                if selectedSort == .yearDescending {
                                    Label(
                                        "Decrescente",
                                        systemImage: "checkmark"
                                    )
                                } else {
                                    Text("Decrescente")
                                }
                            }
                        }
                        
                    } label: {
                        Text(selectedSort.shortTitle)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        
                        Button("Corso") {
                            newCourseType = .graded
                            showingAddCourseSheet = true
                        }
                        
                        Button("Idoneità") {
                            newCourseType = .passFail
                            showingAddCourseSheet = true
                        }
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
            .sheet(isPresented: $showingAddCourseSheet) {
                AddCourseView(
                    career: $career,
                    type: newCourseType
                )
            }
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
    
    private var sortedCourses: [Course] {
        CourseSorter.sort(courses: filteredCourses,by: selectedSort)
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
    @Previewable @State var career = Career(
        fullName: "Mario Rossi",
        courses: [
            Course(name: "Analisi 1", cfu: 9, type: .graded, year: 1, semester: .first, status: .completed, date: Date.now, grade: 27),
            Course(name: "Fisica", cfu: 9, type: .graded, year: 2, semester: .first,
                   status: .planned),
            Course(name: "Inglese 1", cfu: 6, type: .passFail, year: 2, semester: .first,
                   status: .completed)
        ]
    )
    
    LibrettoView(career: $career)
}
