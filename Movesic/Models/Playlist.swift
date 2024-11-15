//
//  Playlist.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

struct Playlist: Hashable, Sendable {
    let name: String
    let tags: [String]
    let songs: [Song]
}

// Sample Data
extension Playlist {
    static let relaxing = Playlist(
        name: "Relax",
        tags: ["Alpha", "Theta", "Relax"],
        songs: [
            .init(thumbnail: "thumbnail-1", name: "Morning Swim", author: "GEA"),
            .init(thumbnail: "thumbnail-2", name: "Enchanted Forest", author: "GEA"),
            .init(thumbnail: "thumbnail-3", name: "Amaphilia", author: "Eamonn O'Dwyer"),
            .init(thumbnail: "thumbnail-4", name: "Light and Shadow", author: "GEA"),
            .init(thumbnail: "thumbnail-5", name: "Happy Chills", author: "GEA")
        ]
    )

    static let focused = Playlist(
        name: "Focused",
        tags: ["Focus", "Creativity", "Alpha", "Beta", "Gama"],
        songs: [
            .init(thumbnail: "thumbnail-6", name: "Serendipity", author: "Marie"),
            .init(thumbnail: "thumbnail-7", name: "Dawn", author: "GEA"),
            .init(thumbnail: "thumbnail-8", name: "Sunrise over Costa Rica", author: "Andrew Hockey"),
            .init(thumbnail: "thumbnail-9", name: "Floating Up", author: "GEA"),
            .init(thumbnail: "thumbnail-10", name: "In the Skin", author: "Marie")
        ]
    )

    static let energizing = Playlist(
        name: "Energizing",
        tags: ["Mood Boost", "Relax", "Alpha", "Beta"],
        songs: [
            .init(thumbnail: "thumbnail-11", name: "No Longer Lost", author: "GEA"),
            .init(thumbnail: "thumbnail-12", name: "I Saw You", author: "GEA"),
            .init(thumbnail: "thumbnail-13", name: "Perfect Land", author: "Marie"),
            .init(thumbnail: "thumbnail-15", name: "Cosy Time", author: "GEA")
        ]
    )
}
