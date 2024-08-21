//
//  DetectCryUseCaseProtocol.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 21/08/24.
//

import Foundation

protocol DetectCryUseCaseProtocol {
    func execute(data: AudioRecordingEntity) async throws -> Bool
}
