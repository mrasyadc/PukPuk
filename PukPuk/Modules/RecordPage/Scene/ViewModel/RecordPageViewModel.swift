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
    private let cancelRecordUseCase: CancelRecordUseCase
    
    init(startRecordUseCase: StartRecordUseCase, stopRecordUseCase: StopRecordUseCase, cancelRecordUseCase: CancelRecordUseCase) {
        self.startRecordUseCase = startRecordUseCase
        self.stopRecordUseCase = stopRecordUseCase
        self.cancelRecordUseCase = cancelRecordUseCase
    }
}
