//
//  ResultProtocol.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

protocol ResultProtocol {
    func getModelResult(url:URL) -> [String : Double]
}