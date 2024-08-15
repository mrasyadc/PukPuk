//
//  RecordPageCoordinator.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation
import SwiftUI
import Combine

public final class RecordPageCoordinator {
    
    private var navigationController: UINavigationController?
    private let audioRepository: AudioRepository
    private let classificationRepository: ClassificationRepository
    
    init(navigationController: UINavigationController? = nil, audioRepository: AudioRepository, classificationRepository: ClassificationRepository) {
        self.navigationController = navigationController
        self.audioRepository = audioRepository
        self.classificationRepository = classificationRepository
    }
    
//    private func makeRecordPageViewController() -> RecordPageViewController {
//        
//    }
    
    // create view Model
    private func makeRecordPageViewModel(
        startRecordUseCase: StartRecordUseCase,
        stopRecordUseCase:StopRecordUseCase, 
        cancelRecordUseCase:CancelRecordUseCase
    ) -> RecordPageViewModel {
        return RecordPageViewModel(startRecordUseCase: startRecordUseCase, stopRecordUseCase: stopRecordUseCase, cancelRecordUseCase: cancelRecordUseCase)
    }
    
    // create use case
    private func makeStartRecordUseCase() -> StartRecordUseCase {
        StartRecordUseCase(repository: audioRepository)
    }
    
    private func makeStopRecordUseCase() -> StopRecordUseCase {
        StopRecordUseCase(repository: audioRepository)
    }
    
    private func makeCancelRecordUseCase() -> CancelRecordUseCase {
        CancelRecordUseCase(repository: audioRepository)
    }
    
    
    // Starting coordinator
}

//func makeAddHabitUseCase() -> AddHabitUseCase {
//    AddHabitUseCase(repository: habitRepository)
//}
//
//func makeGetHabitsUseCase() -> GetHabitsUseCase {
//    GetHabitsUseCase(repository: habitRepository)
//}
