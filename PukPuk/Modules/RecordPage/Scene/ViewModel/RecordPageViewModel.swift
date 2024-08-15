//
//  RecordPageViewModel.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import Combine

internal final class RecordPageViewModel {
    private let startRecordUseCase: StartRecordUseCase
    private let stopRecordUseCase: StopRecordUseCase
    private let getRecordedAudioUseCase: GetRecordedAudioUseCase
    private var cancellables = Set<AnyCancellable>()
    
    let didTapRecordButton = PassthroughSubject<Void, Never>()
    let didStopRecording = PassthroughSubject<Void, Never>()
    let recordedAudio = PassthroughSubject<URL, Never>()

    
    init(startRecordUseCase: StartRecordUseCase, stopRecordUseCase: StopRecordUseCase, getRecordedAudioUseCase: GetRecordedAudioUseCase, cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.startRecordUseCase = startRecordUseCase
        self.stopRecordUseCase = stopRecordUseCase
        self.getRecordedAudioUseCase = getRecordedAudioUseCase
        self.cancellables = cancellables
        
        bindInputs()
    }
    
    private func bindInputs() {
        didTapRecordButton
            .sink { [weak self] in
                self?.startRecording()
            }
            .store(in: &cancellables)
        
        didStopRecording
            .sink { [weak self] in
                self?.stopRecording()
            }
            .store(in: &cancellables)
    }
    
    private func startRecording() {
        startRecordUseCase.execute()
    }
    
    private func stopRecording() {
        stopRecordUseCase.execute()
        // Optionally, fetch recorded audio here
    }
}
