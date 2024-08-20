//
//  ResultPageCoordinator.swift
//  PukPuk
//
//  Created by Jason Susanto on 19/08/24.
//

import UIKit

public final class ResultPageCoordinator {
    private var navigationController: UINavigationController
    private let classificationResult: ClassificationResultEntity
    
    init(navigationController: UINavigationController, classificationResult: ClassificationResultEntity) {
        self.navigationController = navigationController
        self.classificationResult = classificationResult
    }
    
    private func makeResultPageViewController() -> ResultPageViewController {
        let viewModel = DependencyInjection.shared.resultPageViewModel(classificationResult: classificationResult) // create viewModel
        
        let viewController = ResultPageViewController()
        viewController.viewModel = viewModel // inject viewModel
        return viewController
    }
    
    func start() {
        let viewController = makeResultPageViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
