//
//  DetectCryUseCase.swift
//  PukPuk
//
//  Created by Jason Susanto on 20/08/24.
//

import Foundation

final class DetectCryUseCase: DetectCryUseCaseProtocol {
    private let repository: ClassificationRepository

    init(repository: ClassificationRepository) {
        self.repository = repository
    }

    func execute(data: AudioRecordingEntity) async throws -> Bool {
        do {
            let result = try await repository.detectCry(at: data.fileUrl)
            return result
        } catch {
            print("Error detect cry audio: \(error)")
            throw error
        }
    }
}
