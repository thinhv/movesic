//
//  PlaylistView.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

import SwiftUI

struct PlayListView: View {
    let playlist: Playlist

    var body: some View {
        List(playlist.songs, id: \.self) { song in
            HStack(spacing: 8) {
                Image(song.thumbnail)
                    .resizable()
                    .frame(width: 80.0, height: 80.0)
                    .cornerRadius(4.0)
                    .clipped()
                    .padding(.vertical, 8)

                VStack(alignment: .leading) {
                    Text(song.name)
                        .font(.headline)
                    Text(song.author)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview("Relaxing") {
    PlayListView(playlist: .relaxing)
}

#Preview("Focused") {
    PlayListView(playlist: .focused)
}

#Preview("Energizing") {
    PlayListView(playlist: .energizing)
}
