//
//  ResultVCRepresentable.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 15/08/24.
//

import SwiftUI

struct ResultViewControllerRepresentable: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: ResultVC, context: Context) {
        print("yes")
    }
    
    func makeUIViewController(context: Context) -> ResultVC {
        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else{
            fatalError("Cannot find Result View Controller in storyboard")
        }
        return viewController
        
    }
    
    
    
    
}

