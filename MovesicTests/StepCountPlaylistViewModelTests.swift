//
//  StepCountPlaylistViewModelTests.swift
//  MovesicTests
//
//  Created by thinh on 15.11.2024.
//

@testable import Movesic
import XCTest
import HealthKit

@MainActor
final class StepCountPlaylistViewModelTests: XCTestCase {
    var sut: StepCountPlaylistViewModel!
    var mockPlaylistMapper: StepCountPlaylistMapper!
    var mockStepCountProvider: MockStepCountProvider!

    override func setUpWithError() throws {
        mockPlaylistMapper = .mock
        mockStepCountProvider = .init()
        sut = .init(stepProvider: mockStepCountProvider, stepCountPlaylistMapper: mockPlaylistMapper)
    }

    override func tearDownWithError() throws {}

    func test_whenAuthorizationStatusIsNotDetermined_requestAuthorizationIsCalled() async {
        mockStepCountProvider.authorizationStatus = .notDetermined
        mockStepCountProvider.stepCountHandler = { @Sendable _, _ in return 1 }

        XCTAssertEqual(mockStepCountProvider.requestAuthorizationMethodCallCount, 0)

        await sut.task()

        XCTAssertEqual(mockStepCountProvider.requestAuthorizationMethodCallCount, 1)
        switch sut.state {
            case let .loaded(playlist):
                XCTAssertEqual(playlist, .init(name: "Mocked Playlist", tags: ["mock"], songs: []))
            default:
                XCTFail()
        }
    }

    func test_whenAuthorizationFails_stateTransitionsToError() async {
        mockStepCountProvider.authorizationStatus = .notDetermined
        mockStepCountProvider.requestAuthorizationHandler = { @Sendable in throw NSError(domain: "AuthError", code: 1, userInfo: nil) }

        XCTAssertEqual(mockStepCountProvider.requestAuthorizationMethodCallCount, 0)

        await sut.task()

        XCTAssertEqual(mockStepCountProvider.requestAuthorizationMethodCallCount, 1)
        switch sut.state {
            case let .error(error):
                XCTAssertEqual((error as NSError).domain, "AuthError")
            default:
                XCTFail("State should transition to error on authorization failure.")
        }
    }

    func test_whenFetchingStepCountFails_stateTransitionsToError() async {
        mockStepCountProvider.authorizationStatus = .sharingAuthorized
        mockStepCountProvider.stepCountHandler = { @Sendable _, _ in throw NSError(domain: "StepCountError", code: 2, userInfo: nil) }

        await sut.task()

        switch sut.state {
            case let .error(error):
                XCTAssertEqual((error as NSError).domain, "StepCountError")
            default:
                XCTFail("State should transition to error when fetching step count fails.")
        }
    }

    // More similar tests covers different cases...
}

extension HKAuthorizationStatus: @retroactive Equatable {}
