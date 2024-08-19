//
//  ResultViewModel.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

class ResultViewModel : ObservableObject{
    @Published var modelResult : [String: Double] = [:]
    @Published var isNewOpen : Bool
    
    private let resultUseCase : ResultUseCaseProtocol
    
    var cause: String {
        return modelResult.keys.first ?? ""
    }
    
    var percentage: String{
        if let value = modelResult.values.first{
            return "\(value)%"
        }
        return ""
    }
    
    init(resultUseCase: ResultUseCaseProtocol) {
        self.resultUseCase = resultUseCase
        self.isNewOpen = true
    }
    
    func checkAndGetModelResult(){
        if isNewOpen{
            firstOpenApp()
            isNewOpen = false
        }else{
            refreshPage()
        }
    }
    
    func firstOpenApp(){
        modelResult = resultUseCase.getModelResult(url: URL(fileURLWithPath: "a"))
        
    }
    
    func refreshPage(){
        firstOpenApp()
    }
    
    
    
    
}
