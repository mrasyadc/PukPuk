//
//  ResultViewModel.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

internal final class ResultPageViewModel{
    @Published var recommendation: RecommendationEntity?
    @Published var classificationResult: ClassificationResultEntity

    private let getRecommendationUseCase: GetRecommendationUseCase

    init(classificationResult: ClassificationResultEntity, getRecommendationUseCase: GetRecommendationUseCase) {
        self.classificationResult = classificationResult
        self.getRecommendationUseCase = getRecommendationUseCase
//        recommendation = getRecommendationUseCase.execute()
        
        if let topClassification = classificationResult.topClassificationResult {
            recommendation = getRecommendationUseCase.execute(for: topClassification)
        }
    }
}
