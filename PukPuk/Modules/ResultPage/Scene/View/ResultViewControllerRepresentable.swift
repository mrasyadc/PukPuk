//
//  ResultVCRepresentable.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import SwiftUI

struct ResultViewControllerRepresentable: UIViewControllerRepresentable{
    
    @EnvironmentObject var resultViewModel : ResultViewModel
    
    @EnvironmentObject var routingCoordinator: RoutingCoordinator
    
    func updateUIViewController(_ uiViewController: ResultVC, context: Context) {
        uiViewController.vm = resultViewModel
    }
    
    func makeUIViewController(context: Context) -> ResultVC {
        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else{
            fatalError("Cannot find Result View Controller in storyboard")
        }
        return viewController
        
    }
    
    
    
    
}

