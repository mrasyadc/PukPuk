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
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        // Downcast the result to a classification result.
        guard let result = result as? SNClassificationResult else  { return }
        // Get the prediction with the highest confidence.
        for classification in result.classifications {
            let confidence = classification.confidence
            classifications[classification.identifier, default: 0] += confidence
            totalConfidence += confidence
            resultCount += 1
        }
        
        //        // Get the starting time.
        //        let timeInSeconds = result.timeRange.start.seconds
        //
        //
        //        // Convert the time to a human-readable string.
        //        let formattedTime = String(format: "%.2f", timeInSeconds)
        //        print("Analysis result for audio at time: \(formattedTime)")
        //
        //
        //        // Convert the confidence to a percentage string.
        //        let percent = classification.confidence * 100.0
        //        let percentString = String(format: "%.2f%%", percent)
        //
        //
        //        // Print the classification's name (label) with its confidence.
        //        print("\(classification.identifier): \(percentString) confidence.\n")
    }
    
    /// Notifies the observer when a request generates an error.
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The analysis failed: \(error.localizedDescription)")
    }
    
    /// Notifies the observer when a request is complete.
    func requestDidComplete(_ request: SNRequest) {
        if !classifications.isEmpty {
            let averageConfidences = classifications.mapValues { $0 / Double(resultCount) }
            let sortedResults = averageConfidences.sorted { $0.value > $1.value }
            
            print("Final result")
            for (label, confidence) in sortedResults {
                let percentString = String(format: "%.2f%%", confidence * 100)
                print("\(label): \(percentString) confidence")
            }
            
            if let topResult = sortedResults.first {
                print("\nTop prediction: \(topResult.key) with \(String(format: "%.2f%%", topResult.value * 100)) confidence")
                
                let resultString = "\(topResult.key): \(String(format: "%.2f%%", topResult.value * 100)) confidence"
//                viewController?.updateUIWithClassificationResult(resultString)
                
            }
        } else {
//            viewController?.updateUIWithClassificationResult("No classification results obtained")
        }
    }
    
    func reset() {
        classifications = [:]
        totalConfidence = 0.0
        resultCount = 0
    }
}
