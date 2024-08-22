//
//  PukPuk_Tests.swift
//  PukPuk-Tests
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

import CoreML
@testable import PukPuk
import XCTest

final class RecordClassify_Tests: XCTestCase {
    private var classifyUseCase: ClassifyAudioUseCaseProtocol!
    private var classifyRepository: ClassificationRepository!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        lazy var recordingsDirectoryURL: URL = FileManager.default.temporaryDirectory
        
        lazy var babyCryClassifier: BabyCrySoundClassifierFinal? = {
            do {
                return try BabyCrySoundClassifierFinal(configuration: MLModelConfiguration())
            } catch {
                print("error convert model")
                return nil
            }
        }()
        
        if let model = babyCryClassifier?.model {
            classifyRepository = RecordPageRepositoryImpl(
                audioDataSource: audioRecorderDataSource(),
                audioPlayDataSource: audioplayerDataSource(),
                classificationDataSource: classificationDataSource(model: model),
                fileManagerDataSource: DefaultFileManagerDataSource(recordingsDirectoryURL: recordingsDirectoryURL)
            )
        }
        
        classifyUseCase = ClassifyAudioUseCase(repository: classifyRepository)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClassifyRecording() async throws {
        // Use a valid URL for a test file where "not_cry" is expected
        guard let url = Bundle.main.url(forResource: "cry", withExtension: "wav") else {
            XCTFail("URL for the resource is nil.")
            return
        }

        do {
            // Call the function to get classification results
           
            let results = try await classifyUseCase.execute(data: AudioRecordingEntity(fileUrl: url))
            
            // Check that results are not empty
            XCTAssertFalse(results.classifications.isEmpty, "Results should not be empty")
            
//            print(results.classifications)
            // Additional assertions for specific results can be added here
                
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }
}
