//
//  PukPukApp.swift
//  PukPuk
//
//  Created by Muhammad Rasyad Caesarardhi on 13/08/24.
//

import SwiftUI
import Intents

@main
struct PukPukApp: App {
    @State private var userActivity: NSUserActivity?
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    setupSiriActivity()
                }
                .onContinueUserActivity("com.PukPuk.PukPuk.open", perform: handleUserActivity(_:))
                .onContinueUserActivity("com.PukPuk.PukPuk.startRecording", perform: handleUserActivity(_:))
                .onContinueUserActivity("com.PukPuk.PukPuk.stopRecording", perform: handleUserActivity(_:))
        }
    }
    
    private func setupSiriActivity() {
        let openActivity = NSUserActivity(activityType: "com.PukPuk.PukPuk.open")
        openActivity.title = "Open PukPuk"
        openActivity.isEligibleForSearch = true
        openActivity.isEligibleForPrediction = true
        openActivity.persistentIdentifier = NSUserActivityPersistentIdentifier("com.PukPuk.PukPuk.open")
        openActivity.suggestedInvocationPhrase = "Open PukPuk"
        self.userActivity = openActivity
        self.userActivity?.becomeCurrent()
        
        let startRecordingActivity = NSUserActivity(activityType: "com.PukPuk.PukPuk.startRecording")
        startRecordingActivity.title = "Start Recording"
        startRecordingActivity.isEligibleForSearch = true
        startRecordingActivity.isEligibleForPrediction = true
        startRecordingActivity.persistentIdentifier = NSUserActivityPersistentIdentifier("com.PukPuk.PukPuk.startRecording")
        startRecordingActivity.suggestedInvocationPhrase = "Hey Siri, start recording"
        
        let stopRecordingActivity = NSUserActivity(activityType: "com.PukPuk.PukPuk.stopRecording")
        stopRecordingActivity.title = "Stop Recording"
        stopRecordingActivity.isEligibleForSearch = true
        stopRecordingActivity.isEligibleForPrediction = true
        stopRecordingActivity.persistentIdentifier = NSUserActivityPersistentIdentifier("com.PukPuk.PukPuk.stopRecording")
        stopRecordingActivity.suggestedInvocationPhrase = "Hey Siri, stop recording"
        
        // Only set userActivity when needed, avoid consecutive calls
        self.userActivity = openActivity
        self.userActivity?.becomeCurrent()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.userActivity = startRecordingActivity
            self.userActivity?.becomeCurrent()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.userActivity = stopRecordingActivity
            self.userActivity?.becomeCurrent()
        }
    }

    
    private func handleUserActivity(_ userActivity: NSUserActivity) {
        switch userActivity.activityType {
        case "com.PukPuk.PukPuk.open":
            // Handle the open activity, such as navigating to a specific view
            break
        case "com.PukPuk.PukPuk.startRecording":
            // Handle starting the recording
            NotificationCenter.default.post(name: Notification.Name("StartRecording"), object: nil)
        case "com.PukPuk.PukPuk.stopRecording":
            // Handle stopping the recording
            NotificationCenter.default.post(name: Notification.Name("StopRecording"), object: nil)
        default:
            break
        }
    }
}
