//
//  ResultRepositoryImpl.swift
//  PukPuk
//
//  Created by Jason Susanto on 19/08/24.
//

import Foundation

internal class ResultRepositoryImpl: ResultRepository {
    let dataSource: ResultDataSource
    
    init(dataSource: ResultDataSource) {
        self.dataSource = dataSource
    }
    
    func getRecommendation(for classificationResult: ClassificationResult) -> RecommendationEntity {
        dataSource.getRecommendation(for: classificationResult)
    }
}
