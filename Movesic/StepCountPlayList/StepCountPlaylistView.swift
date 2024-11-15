//
//  StepCountPlaylistView.swift
//  Movesic
//
//  Created by thinh on 15.11.2024.
//

import SwiftUI

struct StepCountPlaylistView: View {
    @Environment(StepCountPlaylistViewModel.self) var viewModel

    var body: some View {
        VStack {
            Group {
                switch viewModel.state {
                    case .unauthorized:
                        Text("Authorization Required")
                            .foregroundColor(.red)
                            .padding()

                    case .loading:
                        ProgressView("Loading ...")
                            .padding()
                    case .loaded(let playlist):
                        VStack {
                            Text("Your Playlist: \(playlist.name)")
                                .font(.headline)
                                .padding()

                            PlayListView(playlist: playlist)
                        }

                    case .error(let error):
                        // TODO: Handle error properly
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .padding()
                }
            }
            .navigationBarTitle("Step Count Playlist", displayMode: .large)
            .task {
                await viewModel.task()
            }

            // Show disclaimer due to the fact that app is not possible to
            // know if user as granted Read permission (for step count) or not.
            Text("In order to suggest the best playlist for you, please make sure that you have granted the read permission for Steps.")
                .padding()
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}
