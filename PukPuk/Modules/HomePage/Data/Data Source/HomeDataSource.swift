//
//  HomeDataSource.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import Foundation
import SoundAnalysis

enum CryClassificationError: Equatable, Error, LocalizedError {
    case notCryDetected
    case cryClassificationError(String)

    var errorDescription: String? {
        switch self {
        case .notCryDetected:
            return "Cry classification indicates not a cry. Try again."
        case .cryClassificationError(let message):
            return message
        }
    }
}

class HomeDataSource: HomeLocalDataSourceProtocol {
    func getModelResult(url: URL) async throws -> [String: Double] {
        let cryClassifications = try await classifyCryNotCry(url: url)
        let reasonsClassifications = try await classifyCryReasons(url: url)

        // Check cry_classifications for confidence levels of "cry" and "not_cry"
        if let cryClassification = cryClassifications.first(where: { $0.identifier == "cry" }),
           let notCryClassification = cryClassifications.first(where: { $0.identifier == "not_cry" })
        {
            // Compare confidence levels
            if cryClassification.confidence < notCryClassification.confidence {
                // If "cry" confidence is lower, return an indication to try again
                throw CryClassificationError.notCryDetected
            }
        }

        // Convert the classifications to a [String: Double] dictionary
        let results = reasonsClassifications.reduce(into: [String: Double]()) { dict, classification in
            dict[classification.identifier] = classification.confidence
        }

        return results
    }
}

class ResultObserver: NSObject, SNResultsObserving {
    var completion: ((Result<[SNClassification], Error>) -> Void)?
    private var hasCompleted = false // Flag to ensure continuation is only resumed once

    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let classificationResult = result as? SNClassificationResult, !hasCompleted else { return }
        hasCompleted = true // Set the flag to true after handling the result
        // Process results and pass to completion handler
        completion?(.success(classificationResult.classifications))
    }

    func request(_ request: SNRequest, didFailWithError error: Error) {
        guard !hasCompleted else { return }
        hasCompleted = true // Set the flag to true after handling the error
        // Pass error to completion handler
        completion?(.failure(error))
    }

    func requestDidComplete(_ request: SNRequest) {
        // Handle completion if needed, but avoid resuming the continuation here
    }
}

// Function to classify baby cry and return classifications
func classifyCryNotCry(url: URL) async throws -> [SNClassification] {
    // Reset observer to start fresh
    let resultsObserver = ResultObserver()

    // Create default configuration for the ML model
    let defaultConfig = MLModelConfiguration()

    // Create a continuation for the async/await pattern
    return try await withCheckedThrowingContinuation { continuation in
        resultsObserver.completion = { result in
            switch result {
            case .success(let classifications):
                continuation.resume(returning: classifications)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }

        do {
            // Initialize the baby cry classifier model with the default configuration
            let babyCryClassifier = try CryNotCry(configuration: defaultConfig)

            // Create a sound classification request using the ML model
            let classifySoundRequest = try SNClassifySoundRequest(mlModel: babyCryClassifier.model)

            // Create an audio file analyzer for the provided URL
            if let audioFileAnalyzer = createAnalyzer(audioFileURL: url) {
                // Add the classification request to the analyzer with the results observer
                try audioFileAnalyzer.add(classifySoundRequest, withObserver: resultsObserver)

                // Start the analysis process
                audioFileAnalyzer.analyze()
            } else {
                throw NSError(domain: "Failed to create audio analyzer", code: 0, userInfo: nil)
            }

        } catch {
            // Handle any errors that occur during classification setup
            continuation.resume(throwing: error)
        }
    }
}

// Function to classify baby cry and return classifications
func classifyCryReasons(url: URL) async throws -> [SNClassification] {
    // Reset observer to start fresh
    let resultsObserver = ResultObserver()

    // Create default configuration for the ML model
    let defaultConfig = MLModelConfiguration()

    // Create a continuation for the async/await pattern
    return try await withCheckedThrowingContinuation { continuation in
        resultsObserver.completion = { result in
            switch result {
            case .success(let classifications):
                continuation.resume(returning: classifications)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }

        do {
            // Initialize the baby cry classifier model with the default configuration
            let babyCryClassifier = try BabyCrySoundClassifierFinal(configuration: defaultConfig)

            // Create a sound classification request using the ML model
            let classifySoundRequest = try SNClassifySoundRequest(mlModel: babyCryClassifier.model)

            // Create an audio file analyzer for the provided URL
            if let audioFileAnalyzer = createAnalyzer(audioFileURL: url) {
                // Add the classification request to the analyzer with the results observer
                try audioFileAnalyzer.add(classifySoundRequest, withObserver: resultsObserver)

                // Start the analysis process
                audioFileAnalyzer.analyze()
            } else {
                throw NSError(domain: "Failed to create audio analyzer", code: 0, userInfo: nil)
            }

        } catch {
            // Handle any errors that occur during classification setup
            continuation.resume(throwing: error)
        }
    }
}

// Function to create an audio analyzer
func createAnalyzer(audioFileURL: URL) -> SNAudioFileAnalyzer? {
    return try? SNAudioFileAnalyzer(url: audioFileURL)
}
