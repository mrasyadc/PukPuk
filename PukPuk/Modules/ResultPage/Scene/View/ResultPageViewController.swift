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
    var isCardExpanded: Bool = false
    let newButtonHeight: CGFloat = 200
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var topFirstView: UIView!
    @IBOutlet weak var bottomView: UIView!
//    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resultIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var seeOtherResultButton: UIButton!
    @IBOutlet var seeOtherResultView: UIView!
    
    @IBOutlet var bgResult: UIImageView!
    
    @IBOutlet var tryAgainButton: UIButton!
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var firstOtherResult: UIButton!
    @IBOutlet var fourthOtherResult: UIButton!
    @IBOutlet var thirdOtherResult: UIButton!
    @IBOutlet var secondOtherResult: UIButton!
    
    @IBOutlet var firstOtherImage: UIImageView!
    @IBOutlet var secondOtherIMage: UIImageView!
    @IBOutlet var thirdOtherImage: UIImageView!
    @IBOutlet var fourthOtherImage: UIImageView!
    @IBOutlet var topResultImage: UIImageView!
    
    @IBOutlet var seeLessButton: UIButton!
    @EnvironmentObject var routingCoordinator: RoutingCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        bindViewModel()
    }
    
//    @IBAction func toggleSeeOtherResulth(_ sender: UIButton) {
//        isCardExpanded.toggle()
//
//        seeOtherResultButton.setTitle(isCardExpanded ? "Close other result" : "See other result", for: .normal)
//
//        UIView.animate(withDuration: 0.3){
//            self.cardHeight = self.isCardExpanded ? self.
//            self.seeOtherResultButton.frame = CGRect(x: 0, y: 0, width: .greatestFiniteMagnitude, height: self.newButtonHeight)
//            self.seeOtherResultButton.center = self.view.center
//            self.cardHeightConstraint.constant = self.isCardExpanded ? 300 : 0
//            print(self.cardHeightConstraint.constant)
//            self.view.layoutIfNeeded()
//            self.cardView.bounds.height = self.isCardExpanded ? 300 : 0
//        }
//    }
    
    
    private func setupUI() {
        setupTopResultImage()
        changeBackgroundColor()
        setupTopFirstView()
        setupOtherResultView()
//        setupSeeOtherResultButton()
        setupBottomView()
//        setupCardView()
        setupTryAgainButton()
    }
    
    private func bindViewModel() {
        if let topResult = viewModel.classificationResult.topResult {
            nameLabel.text = topResult.label.capitalized
//            confidenceLabel.text = topResult.confidencePercentage
            self.topResultImage.image = UIImage(named: "\(topResult.label.lowercased())Top")
            
        }
        let classifications = viewModel.classificationResult.classifications
        print(classifications.count)
        
        if classifications.count > 1 {
            let secondResult = classifications[1]
            self.firstOtherResult.setTitle(secondResult.label.localizedCapitalized, for: .normal)
            self.firstOtherImage.image = UIImage(named: secondResult.label.lowercased())
            print(classifications.count)
        }
        if classifications.count > 2 {
            let thirdResult = classifications[2]
            self.secondOtherResult.setTitle(thirdResult.label.localizedCapitalized, for: .normal)
            self.secondOtherIMage.image = UIImage(named: thirdResult.label.lowercased())
        }
        if classifications.count > 3 {
            let fourthResult = classifications[3]
            self.thirdOtherResult.setTitle(fourthResult.label.localizedCapitalized, for: .normal)
            self.thirdOtherImage.image = UIImage(named: fourthResult.label.lowercased())
        }
        if classifications.count > 4 {
            let fifthResult = classifications[4]
            self.fourthOtherResult.setTitle(fifthResult.label.localizedCapitalized, for: .normal)
            self.fourthOtherImage.image = UIImage(named: fifthResult.label.lowercased())
        }
        
        viewModel.$recommendation
            .receive(on: DispatchQueue.main) //guna memastikan di ui keupdate
            .sink { [weak self] recommendation in
                guard let recommendation = recommendation else { return }
                self?.descriptionLabel.text = recommendation.description
                
            }
            .store(in: &cancellables)
    }
    
    @IBAction func tryAgainButton(_ sender: Any) {
//            guard let result = viewModel.classificationResult else { return }

            DispatchQueue.main.async {
                let recordCoordinator = RecordPageCoordinator(navigationController: self.navigationController!, routingCoordinator: self.routingCoordinator)
                recordCoordinator.start()
            }

    }
    
    
    private func changeBackgroundColor() {
//        let backgroundImage = UIImage(resource: .resultBackground)
//        view.backgroundColor = UIColor(patternImage: UIImage(resource: .resultBackground))
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//            view.insertSubview(backgroundImageView, at: 0)
        
    }
    
    private func setupTopFirstView() {
        topFirstView.layer.cornerRadius = 12.0
    }
    
    private func setupBottomView() {
        bottomView.layer.cornerRadius = 12.0
    }
    
//    private func setupSeeOtherResultButton() {
//        seeOtherResultButton.layer.cornerRadius = 12.0
//    }
    
//    private func setupCardView(){
//        cardView.layer.cornerRadius = 12.0
//    }
    
    private func setupOtherResultView(){
        seeOtherResultView.layer.cornerRadius = 12.0
    }
    private func setupTryAgainButton(){
        tryAgainButton.layer.cornerRadius = 21
    }
    private func setupTopResultImage(){
            bgView.layer.cornerRadius = bgView.frame.size.width / 2
        bgView.backgroundColor = .clear // Set your desired background color
        bgView.layer.borderColor = UIColor(resource: .darkPurple).cgColor // Set border color
            bgView.layer.borderWidth = 5.0
            
            // Ensure the image view is in front of the circular background
            if let superview = topResultImage.superview {
                superview.insertSubview(bgView, belowSubview: topResultImage)
            }
            
            // Center the topResultImage within the circularBackgroundView
            topResultImage.center = bgView.center
            
            // Adjust the frame of the image view (if needed)
            // For example, if the image is smaller than the circular background:
//            topResultImage.frame = CGRect(x: 0, y: 0, width: 82, height: 82) // Or any desired size
//            topResultImage.layer.cornerRadius = topResultImage.frame.size.width / 2
//            topResultImage.clipsToBounds = true
    }
}

