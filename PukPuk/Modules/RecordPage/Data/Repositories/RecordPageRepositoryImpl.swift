//
//  RecordPageRepositoryImpl.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import UIKit
import AVFoundation

internal final class RecordPageRepositoryImpl: AudioRepository, ClassificationRepository {
    let audioDataSource: AudioRecorderDataSource
    let audioPlayDataSource: AudioPlayerDataSource
    let classificationDataSource: ClassificationDataSource
    let fileManagerDataSource: DefaultFileManagerDataSource
    
    private var currentAudioFileURL: URL?
    
    init(audioDataSource: AudioRecorderDataSource, audioPlayDataSource: AudioPlayerDataSource, classificationDataSource: ClassificationDataSource, fileManagerDataSource: DefaultFileManagerDataSource) {
        self.audioDataSource = audioDataSource
        self.audioPlayDataSource = audioPlayDataSource
        self.classificationDataSource = classificationDataSource
        self.fileManagerDataSource = fileManagerDataSource
    }
    
    func startRecording() {
        self.configureAudioRecordSession()
        let audioFileName = generateAudioFileName()
        let audioFileURL = URL(filePath: NSTemporaryDirectory() + audioFileName)
        self.currentAudioFileURL = audioFileURL
        do {
            try audioDataSource.startRecording(to: audioFileURL)
        } catch {
            print("Error when start recording")
        }
    }
    
    func stopRecording() {
        audioDataSource.stopRecording()
        
        guard let audioFileURL = currentAudioFileURL else {
            print("No audio file URL found!")
            return
        }
        
//        audioPlayDataSource.configureAudioPlaybackSession()
//        audioPlayDataSource.play(from: audioFileURL)
    }
    
    func cancelRecording() {
        audioDataSource.stopRecording()
    }
    
    func getRecordedAudio() -> URL? {
        return fileManagerDataSource.getLatestRecordedAudio()
    }
    
    func configureAudioRecordSession() {
        audioDataSource.configureRecordSession()
    }
    
    func configureAudioPlaybackSession() {
        audioPlayDataSource.configureAudioPlaybackSession()
    }
    
    func classifyAudio(at audioFileURL: URL) async throws -> ClassificationResultEntity {
        try await classificationDataSource.classifyAudio(at: audioFileURL)
    }
    
    func detectCry(at audioFileURL: URL) async throws -> Bool {
        try await classificationDataSource.detectCry(at: audioFileURL)
    }
    
    // helper
    func generateAudioFileName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let currentDateTime = formatter.string(from: Date())
        return "Rec_\(currentDateTime).m4a"
    }
    
}
