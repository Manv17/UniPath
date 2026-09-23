//
//  EditCourseView.swift
//  UniPath
//
//  Created by Manveer Singh on 24/09/2026.
//

import SwiftUI

struct EditCourseView: View {
    let course: Course
    @Binding var career: Career
    
    @State private var editedName: String
    @State private var editedCFU: Int
    @State private var editedGrade: Int?
    @State private var editedDate: Date
    @State private var editedYear: Int
    @State private var editedSemester: CourseSemester
    @State private var editedStatus: CourseStatus
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        course: Course,
        career: Binding<Career>
    ) {
        self.course = course
        self._career = career
        
        _editedName = State(initialValue: course.name)
        _editedCFU = State(initialValue: course.cfu)
        _editedGrade = State(initialValue: course.grade)
        _editedDate = State(initialValue: course.date ?? Date())
        _editedYear = State(initialValue: course.year)
        _editedSemester = State(initialValue: course.semester)
        _editedStatus = State(initialValue: course.status)
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Dati corso") {
                    
                    TextField(
                        "Nome corso",
                        text: $editedName
                    )
                    
                    Picker("CFU", selection: $editedCFU) {
                        ForEach(3...15, id: \.self) { cfu in
                            Text("\(cfu)").tag(cfu)
                        }
                    }
                    
                    Picker("Anno", selection: $editedYear) {
                        ForEach(1...career.duration, id: \.self) { year in
                            Text("\(year)").tag(year)
                        }
                    }
                    
                    Picker("Semestre", selection: $editedSemester) {
                        ForEach(CourseSemester.allCases, id: \.self) { semester in
                            Text(semester.rawValue).tag(semester)
                        }
                    }
                    
                }
                
                Section("Stato e valutazione"){
                    Picker("Stato", selection: $editedStatus) {
                        ForEach(CourseStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    
                    DatePicker("Data", selection: $editedDate, displayedComponents: .date)
                        .disabled(editedStatus == .toDo)
                        .opacity(editedStatus == .completed || editedStatus == .planned ? 1 : 0.4)
                    
                    if (course.type == .graded) {
                        Stepper(
                            "Voto: \(editedGrade ??  18)",
                            value: Binding(
                                get: { editedGrade ?? 18 },
                                set: { editedGrade = $0 }
                            ),
                            in: 18...30
                        )
                        .disabled(editedStatus != .completed)
                        .opacity(editedStatus == .completed ? 1 : 0.4)
                    }
                }
            }
            .navigationTitle(course.name)
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salva", role: .confirm) {
                        
                        var updatedCourse = course
                        
                        updatedCourse.name = editedName
                        updatedCourse.cfu = editedCFU
                        updatedCourse.year = editedYear
                        updatedCourse.semester = editedSemester
                        updatedCourse.status = editedStatus
                        updatedCourse.date = editedStatus == .toDo ? nil : editedDate
                        
                        if updatedCourse.type == .graded && editedStatus == .completed {
                            updatedCourse.grade = editedGrade ?? 18
                        } else {
                            updatedCourse.grade = nil
                        }
                        
                        if let index = career.courses.firstIndex(
                            where: { currentCourse in
                                currentCourse.id == course.id
                            }
                        ) {
                            career.courses[index] = updatedCourse
                            CareerStorage.save(career)
                        }
                        
                        dismiss()
                    }
                    .disabled(
                        editedName
                            .trimmingCharacters(
                                in: .whitespaces
                            )
                            .isEmpty
                    )
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        
    }
}

//#Preview {
//    EditCourseView()
//}
