//
//  CourseRow.swift
//  UniPath
//
//  Created by Manveer Singh on 29/03/26.
//
import SwiftUI

struct CourseRow: View {
    
    let course: Course
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(course.name)
                    .font(.headline)
                
                Text("\(course.cfu) CFU")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if let grade = course.grade {
                Text("\(grade)")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}


