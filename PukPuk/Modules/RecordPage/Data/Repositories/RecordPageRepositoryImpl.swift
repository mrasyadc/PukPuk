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
    let classificationDataSource: ClassificationDataSource
    let fileManagerDataSource: DefaultFileManagerDataSource
    
    init(audioDataSource: AudioRecorderDataSource, classificationDataSource: ClassificationDataSource, fileManagerDataSource: DefaultFileManagerDataSource) {
        self.audioDataSource = audioDataSource
        self.classificationDataSource = classificationDataSource
        self.fileManagerDataSource = fileManagerDataSource
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
    
    func getRecordedAudio(url: URL) {
        fileManagerDataSource.getAudioFiles(in: url)
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
