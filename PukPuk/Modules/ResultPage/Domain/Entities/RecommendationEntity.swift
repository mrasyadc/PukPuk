//
//  ResultEntity.swift
//  PukPuk
//
//  Created by Jason Susanto on 19/08/24.
//

import Foundation

struct RecommendationEntity {
    let cryType: String
    let description: String
    let steps: [RecommendationStepDetail]
}

struct RecommendationStepDetail {
    let title: String
    let desc: String
}

