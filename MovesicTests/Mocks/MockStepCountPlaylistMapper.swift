//
//  MockStepCountPlaylistMapper.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

@testable import Movesic

extension StepCountPlaylistMapper {
    static let mock = StepCountPlaylistMapper { _ in
        return .init(name: "Mocked Playlist", tags: ["mock"], songs: [])
    }
}
