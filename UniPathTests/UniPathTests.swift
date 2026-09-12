//
//  UniPathTests.swift
//  UniPathTests
//
//  Created by Manveer Singh on 12/09/2026.
//

import Testing
@testable import UniPath

struct UniPathTests {

    @Test
        func completedCFUAreCalculatedCorrectly() {
            let courses = [
                Course(name: "Analisi", cfu: 9, grade: 27),
                Course(name: "Fisica", cfu: 6, grade: 24),
                Course(name: "Programmazione", cfu: 12, grade: 30)
            ]

            let statistics = CareerStatistics(courses: courses)

            #expect(statistics.completedCFU == 27)
        }
    
    @Test
    func weightedAverageIsCalculatedCorrectly() {
        let courses = [
            Course(name: "Analisi", cfu: 9, grade: 27),
            Course(name: "Fisica", cfu: 6, grade: 24),
            Course(name: "Programmazione", cfu: 12, grade: 30)
        ]

        let statistics = CareerStatistics(courses: courses)

        let expectedAverage =
            (27.0 * 9.0 + 24.0 * 6.0 + 30.0 * 12.0) / 27.0

        #expect(abs((statistics.weightedAverage ?? 0) - expectedAverage) < 0.001)
    }

    @Test
    func graduationBaseIsCalculatedCorrectly() {
        let courses = [
            Course(name: "Analisi", cfu: 9, grade: 27),
            Course(name: "Fisica", cfu: 6, grade: 24),
            Course(name: "Programmazione", cfu: 12, grade: 30)
        ]

        let statistics = CareerStatistics(courses: courses)

        let expectedAverage =
            (27.0 * 9.0 + 24.0 * 6.0 + 30.0 * 12.0) / 27.0

        let expectedBase = expectedAverage / 30.0 * 110.0

        #expect(abs((statistics.graduationBase ?? 0) - expectedBase) < 0.001)
    }

    @Test
    func statisticsAreEmptyWhenThereAreNoCompletedCourses() {
        let courses = [
            Course(name: "Analisi", cfu: 9),
            Course(name: "Fisica", cfu: 6)
        ]

        let statistics = CareerStatistics(courses: courses)

        #expect(statistics.completedCFU == 0)
        #expect(statistics.weightedAverage == nil)
        #expect(statistics.graduationBase == nil)
    }
    
    @Test
    func completedCourseWithoutGradeCountsTowardsCFU() {
        let courses = [
            Course(
                name: "Inglese B2",
                cfu: 3,
                status: .completed
            )
        ]

        let statistics = CareerStatistics(courses: courses)

        #expect(statistics.completedCFU == 3)
        #expect(statistics.weightedAverage == nil)
    }
    
    @Test
    func careerCanBeSavedAndLoaded() {
        let career = Career(
            fullName: "Mario Rossi",
            email: "mario.rossi@example.com",
            matricola: "123456",
            enrollmentYear: 2023,
            degreeType: .bachelor,
            courses: [
                Course(
                    name: "Analisi",
                    cfu: 9,
                    grade: 27,
                    status: .completed
                )
            ]
        )

        CareerStorage.save(career)

        let loadedCareer = CareerStorage.load()

        #expect(loadedCareer != nil)
        #expect(loadedCareer?.fullName == "Mario Rossi")
        #expect(loadedCareer?.email == "mario.rossi@example.com")
        #expect(loadedCareer?.matricola == "123456")
        #expect(loadedCareer?.courses.count == 1)
        #expect(loadedCareer?.courses.first?.name == "Analisi")
    }
    
    @Test
    func careerCanBeDeleted() {
        let career = Career(
            fullName: "Mario Rossi"
        )

        CareerStorage.save(career)

        #expect(CareerStorage.load() != nil)

        CareerStorage.delete()

        #expect(CareerStorage.load() == nil)
    }

}
