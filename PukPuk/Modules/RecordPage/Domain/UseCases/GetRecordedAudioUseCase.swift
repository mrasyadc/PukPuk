//
//  GetRecordedAudioUseCase.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation

internal final class GetRecordedAudioUseCase {
    private let repository: AudioRepository
    
    init(repository: AudioRepository) {
        self.repository = repository
    }
    
    func execute() -> URL? {
        repository.getRecordedAudio()
    }
}
