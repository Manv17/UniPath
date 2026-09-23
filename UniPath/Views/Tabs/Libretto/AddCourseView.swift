//
//  AddCourseView.swift
//  UniPath
//
//  Created by Manveer Singh on 23/09/2026.
//

import SwiftUI

struct AddCourseView: View {
    
    @Binding var career: Career
    
    let type: CourseType
    
    @State private var name: String = ""
    @State private var cfu: Int = 6
    @State private var grade: Int? = nil
    @State private var selectedDate: Date = Date()
    @State private var year: Int = 1
    @State private var semester: CourseSemester = .first
    @State private var status: CourseStatus = .toDo
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Dati corso") {
                    TextField("Nome corso", text: $name)
                    
                    Picker("CFU", selection: $cfu) {
                        ForEach(3...15, id: \.self) { cfu in
                            Text("\(cfu)").tag(cfu)
                        }
                    }
                    
                    Picker("Anno", selection: $year) {
                        ForEach(1...career.duration, id: \.self) { year in
                            Text("\(year)").tag(year)
                        }
                    }
                    
                    Picker("Semestre", selection: $semester) {
                        ForEach(CourseSemester.allCases, id: \.self) { semester in
                            Text(semester.rawValue).tag(semester)
                        }
                    }
                }
                
                Section("Stato e valutazione"){
                    Picker("Stato", selection: $status) {
                        ForEach(CourseStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    
                    DatePicker("Data", selection: $selectedDate, displayedComponents: .date)
                        .disabled(status == .toDo)
                        .opacity(status == .completed  || status == .planned ? 1 : 0.4)
                    
                    if (type == .graded) {
                        Stepper(
                            "Voto: \(grade ?? 18)",
                            value: Binding(
                                get: { grade ?? 18 },
                                set: { grade = $0 }
                            ),
                            in: 18...30
                        )
                        .disabled(status != CourseStatus.completed)
                        .opacity(status == .completed ? 1 : 0.4)
                    }
                }
            }
            .navigationTitle(
                type == .graded
                ? "Nuovo corso"
                : "Nuova idoneità"
            )
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(){
                        dismiss()
                    }label:{
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salva"){
                        saveCourse()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
    
    private func saveCourse() {
        
        let finalGrade: Int?
        
        if type == .graded && status == .completed {
            finalGrade = grade ?? 18
        } else {
            finalGrade = nil
        }
        
        let newCourse = Course(name: name,
                               cfu: cfu,
                               type: type,
                               year: year,
                               semester: semester,
                               status: status,
                               date: status == .toDo ? nil : selectedDate,
                               grade: finalGrade)
        
        career.courses.append(newCourse)

        CareerStorage.save(career)

        dismiss()
    }
}

#Preview {
    @Previewable @State var career = Career(
        fullName: "Mario Rossi"
    )
    
    AddCourseView(
        career: $career,
        type: .passFail
    )
}
