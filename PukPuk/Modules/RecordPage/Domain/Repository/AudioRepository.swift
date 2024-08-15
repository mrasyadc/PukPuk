//
//  RecordPageRepository.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Foundation

internal protocol AudioRepository {
    func startRecording()
    func stopRecording()
    func cancelRecording()
    func getRecordedAudio()
    func configureAudioRecordSession() // ini blm
}
