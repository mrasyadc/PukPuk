//
//  RecordPageRepositoryImpl.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import UIKit
import AVFoundation

internal final class RecordPageRepositoryImpl: AudioRepository, ClassificationRepository {
    let audioDataSource: audioRecorderDataSource
    let classificationDataSource: classificationDataSource
    
    init(audioDataSource: audioRecorderDataSource, classificationDataSource: classificationDataSource) {
        self.audioDataSource = audioDataSource
        self.classificationDataSource = classificationDataSource
    }
    
    func startRecording() {
        let audioFileName = generateAudioFileName()
        let audioFileURL = URL(filePath: NSTemporaryDirectory() + audioFileName)
        do {
            try audioDataSource.startRecording(to: audioFileURL)
        } catch {
            print("Error when start recording")
        }
    }
    
    func stopRecording() {
        audioDataSource.stopRecording()
    }
    
    func cancelRecording() {
        audioDataSource.stopRecording()
    }
    
    func getRecordedAudio() {
        print("INi masih belum")
    }
    
    func configureAudioRecordSession() {
        audioDataSource.configureRecordSession()
    }
    
//    func classifyAudio(at audioFileURL: URL) async throws -> ClassificationResultEntity {
//        classificationDataSource.classifyAudio(at: audioFileURL)
//        // lakuin mapping ubah ke benntuk result entity.
//    }
    
//    func prepareClassificationModel() {
//        <#code#>
//    }
//    
//    func resetClassification() {
//        <#code#>
//    }
    
    // helper
    func generateAudioFileName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let currentDateTime = formatter.string(from: Date())
        return "Rec_\(currentDateTime).m4a"
    }
    
}
