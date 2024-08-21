//
//  UserDefaults+Onboarding.swift
//  PukPuk
//
//  Created by Jason Susanto on 22/08/24.
//

// UserDefaults+Onboarding.swift
import Foundation

extension UserDefaults {
    private enum Keys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
    }

    var hasSeenOnboarding: Bool {
        get {
            return bool(forKey: Keys.hasSeenOnboarding)
        }
        set {
            set(newValue, forKey: Keys.hasSeenOnboarding)
        }
    }
}
