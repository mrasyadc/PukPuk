//
//  AnalyzeAudioUseCase.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Foundation
import Combine

internal final class ClassifyAudioUseCase {
    private let repositories: ClassificationRepository
    
    init(repositories: ClassificationRepository) {
        self.repositories = repositories
    }
    
//    func execute(data: AudioRecordingEntity) async -> ClassificationResultEntity {
//        do {
//            let result = try await repositories.classifyAudio(at: data.fileUrl)
//            return result
//        } catch {
//            print("Error classifying audio: \(error)")
//        }
//    }
}
