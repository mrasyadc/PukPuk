//
//  ErrorProtocol.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 15/08/24.
//

import Foundation

enum CryClassificationError: Equatable, Error, LocalizedError {
    case notCryDetected
    case cryClassificationError(String)

    var errorDescription: String? {
        switch self {
        case .notCryDetected:
            return "Cry classification indicates not a cry. Try again."
        case .cryClassificationError(let message):
            return message
        }
    }
}
