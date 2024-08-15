//
//  ClassificationDataSource.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import SoundAnalysis

protocol ClassificationDataSource {
    func classifyAudio(at url: URL) async throws
}

class classificationDataSource: ClassificationDataSource {
    private let model: MLModel
    
    init(model: MLModel) {
        self.model = model
    }
    
    func classifyAudio(at url: URL) async throws {
//        let request = try SNClassifySoundRequest(mlModel: model)
//        let analyzer = try SNAudioFileAnalyzer(url: url)
//        
//        let result = try await withCheckedThrowingContinuation { continuation in
//            do {
//                let observer = ResultsObserver { classification in
//                    continuation.resume(returning: classification)
//                }
//                try analyzer.analyze(with: request, observer: observer)
//            } catch {
//                continuation.resume()
//            }
//        }
    }
    
}
