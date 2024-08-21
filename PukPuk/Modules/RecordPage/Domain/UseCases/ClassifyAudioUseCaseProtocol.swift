//
//  ClassifyAudioUseCaseProtocol.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 21/08/24.
//

import Foundation

protocol ClassifyAudioUseCaseProtocol {
//    MARK: Return GENERICS

    func execute(data: AudioRecordingEntity) async throws -> ClassificationResultEntity
}
