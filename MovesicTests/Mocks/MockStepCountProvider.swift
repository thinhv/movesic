//
//  MockStepCountProvider.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

@testable import Movesic
import HealthKit

final class MockStepCountProvider: StepCountProviding {

    var authorizationStatus: HKAuthorizationStatus = .notDetermined
    var requestAuthorizationHandler: (@Sendable () async throws -> Void)?
    var stepCountHandler: (@Sendable (Date, Date) async throws -> Int)?
    private(set) var requestAuthorizationMethodCallCount = 0
    private(set) var stepCountMethodCall = 0

    func requestAuthorization() async throws {
        requestAuthorizationMethodCallCount += 1
        try await requestAuthorizationHandler?()
    }
    
    func stepCount(from fromDate: Date, to toDate: Date) async throws -> Int {
        stepCountMethodCall += 1

        guard let stepCountHandler else {
            fatalError()
        }

        return try await stepCountHandler(fromDate, toDate)
    }
}
