//
//  ResultUseCase.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

class ResultUseCase : ResultUseCaseProtocol{
    let resultRepository : ResultRepositoryProtocol
    
    init(resultRepository: ResultRepositoryProtocol) {
        self.resultRepository = resultRepository
    }
    func getModelResult(url: URL) -> [String : Double] {
        return resultRepository.getModelResult(url: url)
    }
    
    
}
