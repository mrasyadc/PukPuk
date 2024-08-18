//
//  ResultViewModel.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import Foundation

class ResultViewModel : ObservableObject{
    @Published var modelResult : [String: Double] = ["A" : 1.1]
    @Published var isNewOpen : Bool
    
    private let resultUseCase : ResultUseCaseProtocol
    
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
