//
//  ResultPageViewController.swift
//  PukPuk
//
//  Created by Jason Susanto on 19/08/24.
//

import UIKit
import SwiftUI
import Combine

//struct ResultViewControllerWrapper: UIViewControllerRepresentable {
//    typealias UIViewControllerType = UINavigationController
//
//    var classificationResult: ClassificationResultEntity
//    
//    func makeUIViewController(context: Context) -> UINavigationController {
//        let navigationController = UINavigationController()
//        let coordinator = ResultPageCoordinator(navigationController: navigationController, classificationResult: classificationResult)
//        coordinator.start()
//        return navigationController
//    }
//    
//    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
//        // Update if needed
//    }
//}

class ResultPageViewController: UIViewController {

    var viewModel: ResultPageViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var topFirstView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resultIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeOtherResultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        bindViewModel()
    }
    
    private func setupUI() {
        changeBackgroundColor()
        setupTopFirstView()
        setupSeeOtherResultButton()
        setupBottomView()
    }
    
    private func bindViewModel() {
        if let topResult = viewModel.classificationResult.topResult {
            nameLabel.text = topResult.label
            confidenceLabel.text = topResult.confidencePercentage
        }
        
        viewModel.$recommendation
            .receive(on: DispatchQueue.main) //guna memastikan di ui keupdate
            .sink { [weak self] recommendation in
                guard let recommendation = recommendation else { return }
                self?.descriptionLabel.text = recommendation.description
            }
            .store(in: &cancellables)
    }
    
    private func changeBackgroundColor() {
        view.backgroundColor = UIColor(resource: .purple)
    }
    
    private func setupTopFirstView() {
        topFirstView.layer.cornerRadius = 12.0
    }
    
    private func setupBottomView() {
        bottomView.layer.cornerRadius = 12.0
    }
    
    private func setupSeeOtherResultButton() {
        seeOtherResultButton.layer.cornerRadius = 12.0
    }
}

