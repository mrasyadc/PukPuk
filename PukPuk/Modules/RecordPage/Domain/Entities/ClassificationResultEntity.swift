//
//  ClassificationResultEntity.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Foundation

struct ClassificationResultEntity {
    struct Classification {
        let label: String
        let confidence: Double
        
        var confidencePercentage: String {
            return String(format: "%.2f%%", confidence * 100)
        }
    }
    
    let classifications: [Classification]
    let timestamp: Date
    
    var topResult: Classification? {
        return classifications.first
    }
}
