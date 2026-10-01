//
//  UniPathTests.swift
//  UniPathTests
//
//  Created by Manveer Singh on 12/09/2026.
//

import Testing
@testable import UniPath

@Suite(.serialized)
struct UniPathTests {

    @Test
    func completedCFUAreCalculatedCorrectly() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                grade: 27
            ),

            Course(
                name: "Fisica",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .second,
                status: .completed,
                grade: 24
            ),

            Course(
                name: "Programmazione",
                cfu: 12,
                type: .graded,
                year: 1,
                semester: .second,
                status: .completed,
                grade: 30
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 30
        )

        #expect(statistics.completedCFU == 27)
    }


    @Test
    func weightedAverageIsCalculatedCorrectly() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                grade: 27
            ),

            Course(
                name: "Fisica",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .second,
                status: .completed,
                grade: 24
            ),

            Course(
                name: "Programmazione",
                cfu: 12,
                type: .graded,
                year: 1,
                semester: .second,
                status: .completed,
                grade: 30
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 30
        )

        let expectedAverage =
            (27.0 * 9.0 + 24.0 * 6.0 + 30.0 * 12.0) / 27.0

        #expect(
            abs(
                (statistics.weightedAverage ?? 0)
                - expectedAverage
            ) < 0.001
        )
    }


    @Test
    func graduationBaseIsCalculatedCorrectly() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                grade: 27
            ),

            Course(
                name: "Fisica",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .second,
                status: .completed,
                grade: 24
            ),

            Course(
                name: "Programmazione",
                cfu: 12,
                type: .graded,
                year: 1,
                semester: .second,
                status: .completed,
                grade: 30
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 30
        )

        let expectedAverage =
            (27.0 * 9.0 + 24.0 * 6.0 + 30.0 * 12.0) / 27.0

        let expectedBase =
            expectedAverage / 30.0 * 110.0

        #expect(
            abs(
                statistics.graduationBase
                - expectedBase
            ) < 0.001
        )
    }


    @Test
    func statisticsAreEmptyWhenThereAreNoCompletedCourses() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first
            ),

            Course(
                name: "Fisica",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .second
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 30
        )

        #expect(statistics.completedCFU == 0)
        #expect(statistics.weightedAverage == nil)
        #expect(statistics.graduationBase == 0.0)
    }


    @Test
    func completedPassFailCourseCountsTowardsCFU() {

        let courses = [
            Course(
                name: "Inglese B2",
                cfu: 3,
                type: .passFail,
                year: 1,
                semester: .first,
                status: .completed
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 30
        )

        #expect(statistics.completedCFU == 3)
        #expect(statistics.weightedAverage == nil)
    }


    @Test
    func unfinishedCoursesDoNotCountTowardsStatistics() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first,
                status: .toDo,
                grade: 30
            ),

            Course(
                name: "Fisica",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .second,
                status: .planned,
                grade: 28
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 30
        )

        #expect(statistics.completedCFU == 0)
        #expect(statistics.weightedAverage == nil)
    }


    @Test
    func weightedAverageWithHonorValue31() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                grade: 30,
                honor: true
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 31
        )

        #expect(statistics.weightedAverage == 31)
    }


    @Test
    func weightedAverageWithHonorValue30Point5() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                grade: 30,
                honor: true
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 30.5
        )

        #expect(statistics.weightedAverage == 30.5)
    }


    @Test
    func normalThirtyDoesNotUseHonorValue() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                grade: 30,
                honor: false
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 31
        )

        #expect(statistics.weightedAverage == 30)
    }


    @Test
    func weightedAverageWithHonorAndNormalGrade() {

        let courses = [
            Course(
                name: "Analisi",
                cfu: 9,
                type: .graded,
                year: 1,
                semester: .first,
                status: .completed,
                grade: 30,
                honor: true
            ),

            Course(
                name: "Fisica",
                cfu: 6,
                type: .graded,
                year: 1,
                semester: .second,
                status: .completed,
                grade: 27
            )
        ]

        let statistics = CareerStatistics(
            courses: courses,
            honorValue: 31
        )

        let expectedAverage =
            (31.0 * 9.0 + 27.0 * 6.0) / 15.0

        #expect(
            abs(
                (statistics.weightedAverage ?? 0)
                - expectedAverage
            ) < 0.001
        )
    }


    @Test
    func careerCanBeSavedAndLoaded() {

        CareerStorage.delete()

        let university = University(
            id: "unimore",
            name: "Università degli Studi di Modena e Reggio Emilia",
            shortName: "UNIMORE",
            city: "Modena"
        )

        let career = Career(
            fullName: "Mario Rossi",
            email: "mario.rossi@example.com",
            matricola: "123456",
            university: university,
            enrollmentYear: 2023,
            degreeType: .bachelor,
            courses: [
                Course(
                    name: "Analisi",
                    cfu: 9,
                    type: .graded,
                    year: 1,
                    semester: .first,
                    status: .completed,
                    grade: 30,
                    honor: true
                )
            ],
            honorValue: 31
        )

        CareerStorage.save(career)

        let loadedCareer = CareerStorage.load()

        #expect(loadedCareer != nil)

        #expect(
            loadedCareer?.fullName
            == "Mario Rossi"
        )

        #expect(
            loadedCareer?.email
            == "mario.rossi@example.com"
        )

        #expect(
            loadedCareer?.matricola
            == "123456"
        )

        #expect(
            loadedCareer?.university?.id
            == "unimore"
        )

        #expect(
            loadedCareer?.honorValue
            == 31
        )

        #expect(
            loadedCareer?.courses.count
            == 1
        )

        #expect(
            loadedCareer?.courses.first?.name
            == "Analisi"
        )

        #expect(
            loadedCareer?.courses.first?.honor
            == true
        )

        CareerStorage.delete()
    }


    @Test
    func careerCanBeDeleted() {

        CareerStorage.delete()

        let career = Career(
            fullName: "Mario Rossi"
        )

        CareerStorage.save(career)

        #expect(
            CareerStorage.load() != nil
        )

        CareerStorage.delete()

        #expect(
            CareerStorage.load() == nil
        )
    }
}
