//
//  StepCountPlayListMapper.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

import Foundation

struct StepCountPlaylistMapper {
    var map: (_ stepCount: Int) -> Playlist
}

extension StepCountPlaylistMapper {
    /// Weekly mapper which maps from a total number of steps per week to
    /// a playlist
    static let weeklyMapper: StepCountPlaylistMapper = .init { stepCount in
        switch stepCount {
            case ..<5000:
                return Playlist.relaxing
            case 5000..<10000:
                return Playlist.focused
            default:
                return Playlist.energizing
        }
    }
}
