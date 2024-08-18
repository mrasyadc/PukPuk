//
//  ResultDefaultRepository.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

class ResultDefaultRepository : ResultRepositoryProtocol{
    
    private let resultLocalDataSource : ResultLocalDataSourceProtocol
    
    init(resultLocalDataSource: ResultLocalDataSourceProtocol) {
        self.resultLocalDataSource = resultLocalDataSource
    }
    
    func getModelResult(url: URL) -> [String : Double] {
        return resultLocalDataSource.getModelResult(url: url)
    }
    
}
