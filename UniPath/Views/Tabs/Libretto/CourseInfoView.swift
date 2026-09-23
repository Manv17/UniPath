//
//  CourseInfoView.swift
//  UniPath
//
//  Created by Manveer Singh on 23/09/2026.
//

import SwiftUI

struct CourseInfoView: View {
    
    let course: Course
    @Binding var career: Career
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingEditCourseSheet = false
    @State private var showingDeleteConfirmation = false
    
    private var formattedDate: String {
        guard let date = currentCourse.date else { return "Non disponibile" }
        return date.formatted(date: .numeric, time: .omitted)
    }
    
    private var currentCourse: Course {
        career.courses.first {
            $0.id == course.id
        } ?? course
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Dati corso") {
                    
                    VStack(alignment: .leading) {
                        Text("CFU")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text("\(currentCourse.cfu)")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Anno e semestre")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text("\(currentCourse.year)º anno - \(currentCourse.semester.rawValue)")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Tipo")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text("\(currentCourse.type.rawValue)")
                    }
                    
                }
                
                Section("Stato e valutazione") {
                    VStack(alignment: .leading) {
                        Text("Stato")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        Text("\(currentCourse.status.rawValue)")
                    }
                    
                    if currentCourse.status != .toDo {
                        VStack(alignment: .leading) {
                            
                            Text("Data")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                            
                            Text("\(formattedDate)")
                        }
                    }
                    
                    if (currentCourse.status == .completed) {
                        VStack(alignment: .leading){
                            
                            Text("Voto")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                            
                            if currentCourse.type == .graded {
                                
                                if let grade = currentCourse.grade {
                                    Text("\(grade)")
                                } else {
                                    Text("Non disponibile")
                                }
                                
                            } else {
                                Text("Idoneo")
                            }
                        }
                    }
                }
            }
            .navigationTitle(currentCourse.name)
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showingEditCourseSheet = true
                    } label: {
                        Label("Modifica", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        showingDeleteConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            
            .sheet(isPresented: $showingEditCourseSheet) {
                EditCourseView(course: currentCourse, career: $career)
            }
            .alert("Eliminare il corso?", isPresented: $showingDeleteConfirmation) {
                Button("Annulla", role: .cancel) { }
                
                Button("Elimina", role: .destructive) {
                    career.courses.removeAll { $0.id == course.id }
                    
                    CareerStorage.save(career)
                    
                    dismiss()
                }
            } message: {
                Text("Il corso verrà eliminato dalla tua carriera.")
            }
        }
    }
}

#Preview {
    @Previewable @State var career = Career(
        fullName: "Mario Rossi",
        courses: [
            Course(
                name: "Analisi 1",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                date: Date(),
                grade: 27
            )
        ]
    )
    
    NavigationStack {
        CourseInfoView(
            course: career.courses[0],
            career: $career
        )
    }
}
