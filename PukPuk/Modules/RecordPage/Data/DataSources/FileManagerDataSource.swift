//
//  FileManagerDataSource.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation

protocol FileManagerDataSource {
    func getLatestRecordedAudio() -> URL?
    func createAudioFile(withName name: String, in directory: URL) -> URL
    func deleteAudioFile(at url: URL) throws
}

class DefaultFileManagerDataSource: FileManagerDataSource {
    private let fileManager = FileManager.default
    private let recordingsDirectoryURL: URL

    init(recordingsDirectoryURL: URL) {
        self.recordingsDirectoryURL = recordingsDirectoryURL
    }
    
    func getAudioFiles() -> [URL] {
        guard let enumerator = fileManager.enumerator(at: recordingsDirectoryURL, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) else {
            return []
        }
        return enumerator.compactMap { $0 as? URL }.filter { $0.pathExtension == "m4a" }
    }
    
    func getLatestRecordedAudio() -> URL? {
        let audioFiles = getAudioFiles()
        let sortedFiles = audioFiles.sorted { $0.lastPathComponent.compare($1.lastPathComponent, options: .numeric) == .orderedDescending }
        return sortedFiles.first
    }
    
    func createAudioFile(withName name: String, in directory: URL) -> URL {
        return directory.appendingPathComponent(name).appendingPathExtension("m4a")
    }
    
    func deleteAudioFile(at url: URL) throws {
        try fileManager.removeItem(at: url)
    }
}
