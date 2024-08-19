//
//  ClassificationRepository.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation

internal protocol ClassificationRepository {
    
    func classifyAudio(at audioFileURL: URL) async throws -> ClassificationResultEntity

}
