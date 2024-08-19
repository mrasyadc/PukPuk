//
//  RecordPageCoordinator.swift
//  PukPuk
//
//  Created by Jason Susanto on 15/08/24.
//

import UIKit
import Combine
import CoreML

public final class RecordPageCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func makeRecordPageViewController() -> RecordPageViewController {
        guard let viewModel = DependencyInjection.shared.recordPageViewModel() else {
            return RecordPageViewController()
        }
        
        let viewController = RecordPageViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func start() {
        let viewController = makeRecordPageViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
