//
//  PauseRecordUseCase.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Foundation
import Combine

internal final class CancelRecordUseCase {
    private let repository: AudioRepository
    
    init(repository: AudioRepository) {
        self.repository = repository
    }
    
    func execute() {
        repository.cancelRecording()
    }
}
