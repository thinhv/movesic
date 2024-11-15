//
//  StepCountProviding.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

import HealthKit

/// `StepCountProviding` provides  total number of step count
/// during a period.
protocol StepCountProviding: AnyObject {
    var authorizationStatus: HKAuthorizationStatus { get }

    func requestAuthorization() async throws
    func stepCount(from fromDate: Date, to toDate: Date) async throws -> Int
}

final class StepCountProvider: StepCountProviding {
    private static let stepType = HKQuantityType(.stepCount)

    private let store: HKHealthStore

    var authorizationStatus: HKAuthorizationStatus {
        store.authorizationStatus(for: Self.stepType)
    }

    init(store: HKHealthStore = .init()) {
        self.store = store
    }

    func requestAuthorization() async throws {
        try await store.requestAuthorization(toShare: [], read: [Self.stepType])
    }

    func stepCount(from startDate: Date, to endDate: Date) async throws -> Int {
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.sample(type: Self.stepType, predicate: predicate)],
            sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)]
        )

        return try await descriptor
            .result(for: store)
            .compactMap { $0 as? HKQuantitySample }
            .reduce(0) { partialResult, sample in
                return partialResult + Int(sample.quantity.doubleValue(for: HKUnit.count()))
            }
    }
}
