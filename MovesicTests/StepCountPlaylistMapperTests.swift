//
//  StepCountPlaylistMapperTests.swift
//  MovesicTests
//
//  Created by thinh on 15.11.2024.
//

@testable import Movesic
import XCTest

final class StepCountPlaylistMapperTests: XCTestCase {

    func test_weeklyMapper_returnsRelaxingPlaylist_whenStepsAreLessThan5000() {
        let mapper = StepCountPlaylistMapper.weeklyMapper

        let playlist = mapper.map(4999)

        XCTAssertEqual(playlist, .relaxing, "Expected the relaxing playlist for step counts less than 5000.")
    }

    func test_weeklyMapper_returnsFocusedPlaylist_whenStepsAreBetween5000And9999() {
        let mapper = StepCountPlaylistMapper.weeklyMapper

        let playlistLow = mapper.map(5000)
        let playlistHigh = mapper.map(9999)

        XCTAssertEqual(playlistLow, .focused)
        XCTAssertEqual(playlistHigh, .focused)
    }

    func test_weeklyMapper_returnsEnergizingPlaylist_whenStepsAre10000OrMore() {
        let mapper = StepCountPlaylistMapper.weeklyMapper

        let playlist = mapper.map(10000)

        XCTAssertEqual(playlist, .energizing)
    }

    func test_weeklyMapper_handlesEdgeCases() {
        let mapper = StepCountPlaylistMapper.weeklyMapper

        let playlistZeroSteps = mapper.map(0)
        let playlistMaxRelaxing = mapper.map(4999)
        let playlistMinFocused = mapper.map(5000)
        let playlistMaxFocused = mapper.map(9999)
        let playlistMinEnergizing = mapper.map(10000)

        XCTAssertEqual(playlistZeroSteps, .relaxing)
        XCTAssertEqual(playlistMaxRelaxing, .relaxing)
        XCTAssertEqual(playlistMinFocused, .focused)
        XCTAssertEqual(playlistMaxFocused, .focused)
        XCTAssertEqual(playlistMinEnergizing, .energizing)
    }
}
