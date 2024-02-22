//
//  ContentView.swift
//  ibMusic
//
//  Created by Ian Brown on 2/22/24.
//

import SwiftUI
import AVFoundation
struct PickSong: View {
    @Binding var songFile: URL?
    @State private var showFileImporter = false
    @State private var player: AVPlayer?

    var body: some View {
        Button {
            showFileImporter = true
        } label: {
            Label("Choose song", systemImage: "doc.circle")
        }
        .fileImporter(
            isPresented: $showFileImporter,
            allowedContentTypes: [.audio]
        ) { result in
            switch result {
            case .success(let url):
                songFile = url
                self.player = AVPlayer(url: url)
                self.player?.actionAtItemEnd = .none
            case .failure(let error):
                // handle error
                print(error)
            }
        }
        HStack
        {
            Button("Play")
            {
                self.player?.play()
            }
            Button("Pause")
            {
                self.player?.pause()
            }
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var selectedSong: URL?
    var body: some View {
        return PickSong(songFile: $selectedSong)
    }
}
    #Preview 
    {
        ContentView()
    }
