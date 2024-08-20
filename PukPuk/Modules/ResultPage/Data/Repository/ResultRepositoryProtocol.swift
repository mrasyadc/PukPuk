//
//  ResultRepositoryProtocol.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

protocol ResultRepositoryProtocol{
    func getModelResult(url : URL) -> [String : Double]
}
