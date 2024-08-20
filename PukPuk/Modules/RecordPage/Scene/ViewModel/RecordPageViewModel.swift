//
//  RecordPageViewModel.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import Combine

internal final class RecordPageViewModel {
    @Published var recordingState: AudioRecordingState = .idle
    @Published var classificationResult: ClassificationResultEntity?
    @Published var shouldNavigateToResult = false

    private var currentRecording: AudioRecordingEntity?
    
    private let startRecordUseCase: StartRecordUseCase
    private let stopRecordUseCase: StopRecordUseCase
    private let getRecordedAudioUseCase: GetRecordedAudioUseCase
    private let classifyAudioUseCase: ClassifyAudioUseCase
    private let detectCryUseCase: DetectCryUseCase
    private var cancellables = Set<AnyCancellable>()
    
    let didTapRecordButton = PassthroughSubject<Void, Never>()
    let didStopRecording = PassthroughSubject<Void, Never>()
    let recordedAudio = PassthroughSubject<URL, Never>()

    init(startRecordUseCase: StartRecordUseCase, 
         stopRecordUseCase: StopRecordUseCase,
         getRecordedAudioUseCase: GetRecordedAudioUseCase,
         classifyAudioUseCase: ClassifyAudioUseCase,
         detectCryUseCase: DetectCryUseCase,
         cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ){
        self.startRecordUseCase = startRecordUseCase
        self.stopRecordUseCase = stopRecordUseCase
        self.getRecordedAudioUseCase = getRecordedAudioUseCase
        self.classifyAudioUseCase = classifyAudioUseCase
        self.detectCryUseCase = detectCryUseCase
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
                Task { [weak self] in
                    await self?.stopRecording()
                }
            }
            .store(in: &cancellables)
    }
    
    private func startRecording() {
        startRecordUseCase.execute()
        recordingState = .recording
    }
    
    private func stopRecording() async {
        stopRecordUseCase.execute()
        recordingState = .analyzing
        
        let recordedAudioURL = getRecordedAudioUseCase.execute()
        
        if let url = recordedAudioURL {
            print("Recorded url: \(url)")
            
            currentRecording = AudioRecordingEntity(fileUrl: url)
            
            if let recording = currentRecording {
                do {
                    
                    let isCry = try await detectCryUseCase.execute(data: recording)
                    
                    //Kalau true baby is crying
                    if isCry {
                        print("Baby is crying")
                        let classificationResult = try await classifyAudioUseCase.execute(data: recording)
                        self.classificationResult = classificationResult
                        
                        print("Classification result:")
                        for classification in classificationResult.classifications {
                            print("\(classification.label): \(classification.confidencePercentage)")
                        }
                        
                        if let topResult = classificationResult.topResult {
                            print("Top result: \(topResult.label) with \(topResult.confidencePercentage) confidence")
                        }
                        
                        shouldNavigateToResult = true // navigate to result Page
                    } else { // kalau baby not crying.
                        print("The sound is not a baby cry")
                    }
                    
                    
                } catch {
                    print("Error during classification: \(error)")
                }
            }
        }
    }
}
