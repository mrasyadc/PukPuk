//
//  ClassificationDataSource.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import SoundAnalysis

protocol ClassificationDataSource {
    func classifyAudio(at url: URL) async throws -> ClassificationResultEntity
}

class classificationDataSource: ClassificationDataSource {
    
    private let model: MLModel
    
    init(model: MLModel) {
        self.model = model
    }

    func classifyAudio(at url: URL) async throws -> ClassificationResultEntity {
        let resultsObserver = ResultsObserver()
        
        let defaultConfig = MLModelConfiguration()
        
        do {
            let babyCryClassifier = try BabyCrySoundClassifierFinal(configuration: defaultConfig)
            let classifySoundRequest = try SNClassifySoundRequest(mlModel: babyCryClassifier.model)
            let audioFileAnalyzer = try SNAudioFileAnalyzer(url: url)
            
            return try await withCheckedThrowingContinuation { continuation in
                resultsObserver.onCompletion = { finalResults in
                    let classifications = finalResults.map {
                        ClassificationResultEntity.Classification(label: $0.key, confidence: $0.value)
                    }.sorted { $0.confidence > $1.confidence }
                    
                    let result = ClassificationResultEntity(
                        classifications: classifications,
                        timestamp: Date()
                    )
                    continuation.resume(returning: result)
                }
                do {
                    try audioFileAnalyzer.add(classifySoundRequest, withObserver: resultsObserver)
                    audioFileAnalyzer.analyze()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        } catch {
            throw error
        }
    }
}
