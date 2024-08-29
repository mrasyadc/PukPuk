//
//  DependencyInjection.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caearardhi on 13/08/24.
//

import Foundation
import SwiftData
import CoreML

// Grouping UseCase ke dalam satu fungsi
class DependencyInjection: ObservableObject {
    static let shared = DependencyInjection()

    private init() {}

    lazy var homeDataSource = HomeLocalDataSource()

    lazy var homeDefaultRepository = HomeDefaultRepository(homeLocalDataSource: homeDataSource)
    lazy var homeUseCase = HomeUseCase(homeRepository: homeDefaultRepository)

    // MARK: FUNCTION

    func homeViewModel() -> HomeViewModel {
        HomeViewModel(homeUseCase: homeUseCase)
    }
    
    // ML Model
    lazy var babyCryClassifier: BabyCrySoundClassifierFinal? = {
        do {
            return try BabyCrySoundClassifierFinal(configuration: MLModelConfiguration())
        } catch {
            print("error convert model")
            return nil
        }
    }()
    
    lazy var recordingsDirectoryURL: URL = FileManager.default.temporaryDirectory

    //MARK: - Depdency Injection Record Page
    func recordPageViewModel() -> RecordPageViewModel? {
        if let model = babyCryClassifier?.model {
            let audioRepository = RecordPageRepositoryImpl(
                audioDataSource: audioRecorderDataSource(),
                audioPlayDataSource: audioplayerDataSource(),
                classificationDataSource: classificationDataSource(model: model),
                fileManagerDataSource: DefaultFileManagerDataSource(recordingsDirectoryURL: recordingsDirectoryURL)
            )

            return RecordPageViewModel(
                startRecordUseCase: StartRecordUseCase(repository: audioRepository),
                stopRecordUseCase: StopRecordUseCase(repository: audioRepository),
                getRecordedAudioUseCase: GetRecordedAudioUseCase(repository: audioRepository),
                classifyAudioUseCase: ClassifyAudioUseCase(repository: audioRepository),
                detectCryUseCase: DetectCryUseCase(repository: audioRepository)
            )
        } else {
            print("Error: Failed to initialize babyCryClassifier")
            return nil
        }
    }
    
    //MARK: - Depedency Injection Result Page
    func resultPageViewModel(classificationResult: ClassificationResultEntity) -> ResultPageViewModel {
        let resultRepository = ResultRepositoryImpl(dataSource: ResultDataSource())
        
        return ResultPageViewModel(classificationResult: classificationResult, getRecommendationUseCase: GetRecommendationUseCase(repository: resultRepository))
    }
    
}
