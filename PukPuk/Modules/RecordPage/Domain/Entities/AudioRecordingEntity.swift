//
//  AudioData.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Foundation

enum AudioRecordingState {
    case idle
    case recording
    case analyzing
}

struct AudioRecordingEntity {
    let fileUrl: URL
    let duration: TimeInterval
}
