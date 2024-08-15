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
    var isPlaying: Bool { get }
}

class audioplayerDataSource: AudioPlayerDataSource {
    private var audioPlayer: AVAudioPlayer?
    
    func play(from url: URL) { // setiap sebelum play hrs configure sessionya
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
    
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
}
