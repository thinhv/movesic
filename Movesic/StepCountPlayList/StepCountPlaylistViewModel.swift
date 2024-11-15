//
//  StepCountPlayListViewModel.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class StepCountPlaylistViewModel {
    enum PlaylistError: Error {
        case invalidStartDate
    }

    private(set) var state: State = .loading

    @ObservationIgnored
    private let stepProvider: StepCountProviding
    @ObservationIgnored
    private let stepCountPlaylistMapper: StepCountPlaylistMapper

    init(
        stepProvider: StepCountProviding,
        stepCountPlaylistMapper: StepCountPlaylistMapper = .weeklyMapper
    ) {
        self.stepProvider = stepProvider
        self.stepCountPlaylistMapper = stepCountPlaylistMapper
    }

    func task() async {
        do {
            switch stepProvider.authorizationStatus {
                case .notDetermined:
                    try await stepProvider.requestAuthorization()
                    try await loadPlaylist()
                case .sharingDenied:
                    // NOTE: It is not possible to know if user granted or denied permission to read data from HealthKit.
                    // Therefore, try to load the playlist even if the read permission has not been granted.
                    try await loadPlaylist()
                case .sharingAuthorized:
                    try await loadPlaylist()
                @unknown default:
                    break
            }
        } catch {
            state = .error(error)
        }
    }

    private func loadPlaylist() async throws {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)

        guard let startDate else {
            state = .error(PlaylistError.invalidStartDate)
            return
        }

        let stepCount = try await stepProvider.stepCount(from: startDate, to: endDate)
        let playlist = stepCountPlaylistMapper.map(stepCount)
        state = .loaded(playlist)
    }
}

// MARK: - StepCountPlayListViewModel.State
extension StepCountPlaylistViewModel {
    enum State {
        case unauthorized
        case loading
        case loaded(Playlist)
        case error(Error)
    }
}
