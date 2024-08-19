//
//  ResultDataSource.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

class ResultDataSource : ResultLocalDataSourceProtocol {
    func getModelResult(url: URL) -> [String : Double] {
        return ["Hungry" : 75]
    }
    
    
}
