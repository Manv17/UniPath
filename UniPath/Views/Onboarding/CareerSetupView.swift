//
//  CareerSetupView.swift
//  UniPath
//
//  Created by Manveer Singh on 12/09/2026.
//

import SwiftUI

struct CareerSetupView: View {

    let onComplete: (Career) -> Void

    @State private var currentStep = 0

    // Dati personali
    @State private var fullName = ""
    @State private var email = ""
    @State private var matricola = ""

    // Carriera
    @State private var university: University?
    @State private var enrollmentYear =
        Calendar.current.component(.year, from: Date())
    @State private var degreeType: DegreeType = .bachelor

    // Lode
    @State private var honorValue = 30.0

    // Student ID
    @State private var studentIDData: Data?

    var body: some View {
        VStack(spacing: 0) {

            Group {
                switch currentStep {

                case 0:
                    PersonalSetupView(
                        fullName: $fullName,
                        email: $email,
                        matricola: $matricola
                    )

                case 1:
                    AcademicSetupView(
                        university: $university,
                        enrollmentYear: $enrollmentYear,
                        degreeType: $degreeType
                    )

                case 2:
                    GradeSetupView(
                        honorValue: $honorValue
                    )

                case 3:
                    StudentIDSetupView(
                        selectedImageData: $studentIDData
                    )

                case 4:
                    ReadySetupView(
                        name: fullName
                    )

                default:
                    EmptyView()
                }
            }

            if currentStep < 4 {
                progressIndicator
                    .padding(.horizontal)
                    .padding(.top)
            }

            navigationButtons
                .padding()
        }
        .background(
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
        )
    }

    private var progressIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<4, id: \.self) { step in
                Capsule()
                    .fill(
                        step <= currentStep
                        ? Color.accentColor
                        : Color.secondary.opacity(0.2)
                    )
                    .frame(height: 4)
                    .animation(.easeInOut, value: currentStep)
            }
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: 12) {

            if currentStep == 4 {

                Spacer()

                Button("Inizia a usare UniPath") {
                    continueOnboarding()
                }
                .fontWeight(.semibold)
                .frame(minWidth: 220)
                .buttonStyle(.glassProminent)
                .controlSize(.extraLarge)

                Spacer()

            } else {

                if currentStep > 0 {
                    Button("Indietro") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep -= 1
                        }
                    }
                    .controlSize(.large)
                }

                Spacer()

                if currentStep == 3 {
                    Button("Salta") {
                        studentIDData = nil
                        currentStep = 4
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)
                }

                Button("Avanti") {
                    continueOnboarding()
                }
                .buttonStyle(.glassProminent)
                .disabled(!canContinue)
                .controlSize(.large)
            }
        }
    }

    private var canContinue: Bool {
        switch currentStep {

        case 0:
            return !fullName
                .trimmingCharacters(in: .whitespaces)
                .isEmpty

        case 1:
            return true

        case 2:
            return honorValue >= 30

        case 3:
            return true

        case 4:
            return true

        default:
            return false
        }
    }

    private func continueOnboarding() {

        if currentStep == 3 {

            if let studentIDData {
                StudentIDStorage.save(studentIDData)
            }

            withAnimation(.easeInOut(duration: 0.3)) {
                currentStep = 4
            }
            return
        }

        if currentStep < 4 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentStep += 1
            }
            return
        }

        createCareer()
    }

    private func createCareer() {

        let career = Career(
            fullName: fullName,
            email: email,
            matricola: matricola,
            university: university,
            enrollmentYear: enrollmentYear,
            degreeType: degreeType,
            honorValue: honorValue
        )

        CareerStorage.save(career)

        onComplete(career)
    }
}

#Preview {
    CareerSetupView { _ in }
}
