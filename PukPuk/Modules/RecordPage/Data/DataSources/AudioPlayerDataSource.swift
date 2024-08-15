//
//  AudioPlayerDataSource.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import AVFoundation

protocol AudioPlayerDataSource {
    func play(from url: URL)
    func stop()
    func configureAudioPlaybackSession()
    var isPlaying: Bool { get }
    
}

class audioplayerDataSource: AudioPlayerDataSource {
    private var audioPlayer: AVAudioPlayer?
    
    func play(from url: URL) { 
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio file: \(error)")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
    }
    
    func configureAudioPlaybackSession() {
        // Retrieve the shared audio session.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category and mode.
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set the audio session configuration")
        }
    }
    
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
}
