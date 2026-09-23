//
//  CourseRow.swift
//  UniPath
//
//  Created by Manveer Singh on 29/03/26.
//
import SwiftUI

struct CourseRow: View {
    
    let course: Course
    
    private var formattedDate: String {
        guard let date = course.date else { return "" }
        return date.formatted(date: .numeric, time: .omitted)
    }
    
    private var formattedGrade: String? {
        
        if (course.type == .passFail) {
            return course.status == CourseStatus.completed ? "Idoneo" : nil
        } else {
            guard let grade = course.grade else { return nil }
            return "\(grade)"
        }
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(course.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8) {
                    Text("\(course.cfu) CFU")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("•")
                        .foregroundStyle(.tertiary)
                    
                    Text(course.status.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing,spacing: 8) {
                
                if let formattedGrade {
                    
                    Text(formattedGrade)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                
                Text(formattedDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

#Preview{
    CourseRow(course: Course(name: "Anlisi 1", cfu: 9, type: .graded, year: 1, semester: .first, status: .completed, date: Date.now, grade: 27))
}
