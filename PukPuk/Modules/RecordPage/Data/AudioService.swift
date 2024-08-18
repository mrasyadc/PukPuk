//
//  AudioService.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import UIKit
import AVFoundation

struct AudioService {
    
    func configureAudioRecordSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set the audio session configuration")
        }
    }
    
    func generateAudioFileName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let currentDateTime = formatter.string(from: Date())
        return "Rec_\(currentDateTime).m4a"
    }
}
