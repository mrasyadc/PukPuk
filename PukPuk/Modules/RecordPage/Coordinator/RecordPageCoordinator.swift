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
    private var routingCoordinator: RoutingCoordinator
    
    init(navigationController: UINavigationController, routingCoordinator: RoutingCoordinator) {
        self.navigationController = navigationController
        self.routingCoordinator = routingCoordinator
    }
    
    private func makeRecordPageViewController() -> RecordPageViewController {
        let viewController = RecordPageViewController()
        return viewController
    }
    
    func start() {
        let viewController = makeRecordPageViewController()
        
        let viewModel = DependencyInjection.shared.recordPageViewModel()
        viewController.viewModel = viewModel
        viewController.routingCoordinator = routingCoordinator
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
