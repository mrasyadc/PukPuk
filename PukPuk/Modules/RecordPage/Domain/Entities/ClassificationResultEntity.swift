//
//  ClassificationResultEntity.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Foundation

enum ClassificationResult: String {
    case tired
    case hungry
    case belly_pain
    case discomfort
    case burping
    
    init?(label: String) {
        switch label.lowercased() {
        case "tired": self = .tired
        case "hungry": self = .hungry
        case "belly_pain": self = .belly_pain
        case "discomfort": self = .discomfort
        case "burping": self = .burping
        default: return nil
        }
    }
}

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
    
    var secondResult: Classification?{
        return classifications[1]
    }
    
    var thirdResult: Classification?{
        return classifications[2]
    }
    
    var fourthResult: Classification?{
        return classifications[3]
    }
    
    var fifthResult: Classification?{
        return classifications[4]
    }
    
    
    var topClassificationResult: ClassificationResult? {
        guard let topResult = topResult else { return nil }
        return ClassificationResult(label: topResult.label)
    }
    
    var secondClassificationResult: ClassificationResult?{
        guard let secondResult = secondResult else { return nil }
        return ClassificationResult(label: secondResult.label)
    }
    
    var thirdClassificationResult: ClassificationResult?{
        guard let thirdResult = thirdResult else { return nil }
        return ClassificationResult(label: thirdResult.label)
    }
    
    var fourthClassificationResult: ClassificationResult?{
        guard let fourthResult = fourthResult else { return nil }
        return ClassificationResult(label: fourthResult.label)
    }
    
    var fifthClassificationResult: ClassificationResult?{
        guard let fifthResult = fifthResult else { return nil }
        return ClassificationResult(label: fifthResult.label)
    }
}
