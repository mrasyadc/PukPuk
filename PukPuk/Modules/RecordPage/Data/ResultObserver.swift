//
//  ResultObserver.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import SoundAnalysis

/// An observer that receives results from a classify sound request.
class ResultsObserver: NSObject, SNResultsObserving {
    /// Notifies the observer when a request generates a prediction.
    weak var viewController: RecordPageViewController?
    
    private var classifications: [String: Double] = [:]
    private var totalConfidence: Double = 0.0
    private var resultCount: Int = 0

    var onCompletion: (([String: Double]) -> Void)?
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else  { return }
        // Get the prediction with the highest confidence.
        for classification in result.classifications {
            let confidence = Double(classification.confidence)
            classifications[classification.identifier, default: 0] += confidence
            totalConfidence += confidence
            resultCount += 1
        }
    }
    
    /// Notifies the observer when a request generates an error.
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The analysis failed: \(error.localizedDescription)")
    }
    
    /// Notifies the observer when a request is complete.
    func requestDidComplete(_ request: SNRequest) {
        if !classifications.isEmpty {
            let averageConfidences = classifications.mapValues { $0 / Double(resultCount) }
//            let averageConfidences = classifications
            onCompletion?(averageConfidences)
        } else {
            onCompletion?([:])
        }
    }
    
    func reset() {
        classifications = [:]
        totalConfidence = 0.0
        resultCount = 0
    }
}
