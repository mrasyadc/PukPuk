//
//  ResultViewModel.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

internal final class ResultPageViewModel{
    @Published var recordingState: AudioRecordingState = .idle
    @Published var recommendation1: RecommendationEntity?
    @Published var recommendation2: RecommendationEntity?
    @Published var recommendation3: RecommendationEntity?
    @Published var recommendation4: RecommendationEntity?
    @Published var recommendation5: RecommendationEntity?
    @Published var classificationResult: ClassificationResultEntity
    @Published var shouldNavigateRecord = false
    
    private let getRecommendationUseCase: GetRecommendationUseCase

    init(classificationResult: ClassificationResultEntity, getRecommendationUseCase: GetRecommendationUseCase) {
        self.classificationResult = classificationResult
        self.getRecommendationUseCase = getRecommendationUseCase
//        recommendation = getRecommendationUseCase.execute()
        
        if let topClassification = classificationResult.topClassificationResult {
            recommendation1 = getRecommendationUseCase.execute(for: topClassification)
        }
        if let secondClassificationResult = classificationResult.secondClassificationResult{
            recommendation2 = getRecommendationUseCase.execute(for: secondClassificationResult)
        }
        if let thirdClassificationResult = classificationResult.thirdClassificationResult{
            recommendation3 = getRecommendationUseCase.execute(for: thirdClassificationResult)
        }
        if let fourthClassificationResult = classificationResult.fourthClassificationResult{
            recommendation4 = getRecommendationUseCase.execute(for: fourthClassificationResult)
        }
        if let fifthClassificationResult = classificationResult.fifthClassificationResult{
            recommendation5 = getRecommendationUseCase.execute(for: fifthClassificationResult)
        }
    }
    func resetToIdle() {
        shouldNavigateRecord = false
        recordingState = .idle
    }
}
