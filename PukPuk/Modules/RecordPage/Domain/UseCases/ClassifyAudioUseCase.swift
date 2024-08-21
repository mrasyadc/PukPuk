//
//  AnalyzeAudioUseCase.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Foundation
import Combine

internal final class ClassifyAudioUseCase {
    private let repository: ClassificationRepository
    
    init(repository: ClassificationRepository) {
        self.repository = repository
    }
    
    func execute(data: AudioRecordingEntity) async throws -> ClassificationResultEntity {
        do {
            let result = try await repository.classifyAudio(at: data.fileUrl)
            return result
        } catch {
            print("Error classifying audio: \(error)")
            throw error
        }
    }
}
