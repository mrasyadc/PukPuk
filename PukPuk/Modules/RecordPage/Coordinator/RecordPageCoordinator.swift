//
//  RecordPageCoordinator.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import UIKit
import Combine
import CoreML

public final class RecordPageCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func makeRecordPageViewController() -> RecordPageViewController {
        let babyCryClassifier: BabyCrySoundClassifierFinal

        
        do {
            babyCryClassifier = try BabyCrySoundClassifierFinal(configuration: MLModelConfiguration())
        } catch {
            print("error convert model")
            return RecordPageViewController()
        }

        // default URL
        let recordingsDirectoryURL = FileManager.default.temporaryDirectory

        
        let audioRepository = RecordPageRepositoryImpl(
            audioDataSource: audioRecorderDataSource(), 
            audioPlayDataSource: audioplayerDataSource(),
            classificationDataSource: classificationDataSource(model: babyCryClassifier.model),
            fileManagerDataSource: DefaultFileManagerDataSource(recordingsDirectoryURL: recordingsDirectoryURL))
        
        // List add use case
        let startRecordUseCase = StartRecordUseCase(repository: audioRepository)
        let stopRecordUseCase = StopRecordUseCase(repository: audioRepository)
        let getRecordedAudioUseCase = GetRecordedAudioUseCase(repository: audioRepository)
        let classifyAudioUseCase = ClassifyAudioUseCase(repository: audioRepository)
        
        let viewModel = RecordPageViewModel(
             startRecordUseCase: startRecordUseCase,
             stopRecordUseCase: stopRecordUseCase,
             getRecordedAudioUseCase: getRecordedAudioUseCase, 
             classifyAudioUseCase: classifyAudioUseCase
         )
        
        let viewController = RecordPageViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func start() {
        let viewController = makeRecordPageViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
