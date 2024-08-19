//
//  AudioRecorderDataSource.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import AVFoundation

protocol AudioRecorderDataSource {
    func startRecording(to url: URL) throws
    func stopRecording()
    func configureRecordSession()
    var isRecording: Bool { get }
}

class audioRecorderDataSource: AudioRecorderDataSource {
    private var audioRecorder: AVAudioRecorder?
    
    func startRecording(to url: URL) throws {
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        audioRecorder = try AVAudioRecorder(url: url, settings: settings)
        audioRecorder?.record()
    }
    
    func stopRecording() {
        audioRecorder?.stop()
    }
 
    var isRecording: Bool {
        return audioRecorder?.isRecording ?? false
    }
    
    func configureRecordSession() {
        // Retrieve the shared audio session.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category and mode.
            try audioSession.setCategory(.record, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set the audio session configuration")
        }
    }
}
