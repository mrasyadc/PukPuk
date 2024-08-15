//
//  FileManagerDataSource.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import Foundation

protocol FileManagerDataSource {
    func getAudioFiles(in directory: URL) -> [URL]
    func createAudioFile(withName name: String, in directory: URL) -> URL
    func deleteAudioFile(at url: URL) throws
}

class DefaultFileManagerDataSource: FileManagerDataSource {
    private let fileManager = FileManager.default
    
    func getAudioFiles(in directory: URL) -> [URL] {
        guard let enumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) else {
            return []
        }
        return enumerator.compactMap { $0 as? URL }.filter { $0.pathExtension == "m4a" }
    }
    
    func createAudioFile(withName name: String, in directory: URL) -> URL {
        return directory.appendingPathComponent(name).appendingPathExtension("m4a")
    }
    
    func deleteAudioFile(at url: URL) throws {
        try fileManager.removeItem(at: url)
    }
}
