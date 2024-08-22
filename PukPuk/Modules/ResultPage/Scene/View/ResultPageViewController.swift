import UIKit
import SwiftUI
import Combine

class ResultPageViewController: UIViewController {

    var viewModel: ResultPageViewModel!
    var isCardExpanded: Bool = false
    let newButtonHeight: CGFloat = 200
    private var cancellables = Set<AnyCancellable>()
    private var currentPublisher: AnyCancellable?
//    var routingCoordinator : RoutingCoordinator!
    var onTryAgainTapped: (() -> Void)?
    
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var topFirstView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resultIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
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
    @IBOutlet var feedbackView: UIView!
    @IBOutlet var feedbackButton: UIButton!
    @IBOutlet var seeLessButton: UIButton!
    @IBOutlet var micButton: UIButton!
    
    @IBOutlet var titleLabels: [UILabel]!
    
    @EnvironmentObject var routingCoordinator: RoutingCoordinator

    override func viewDidLoad() {
        super.viewDidLoad()
//        let swiftUIView = RecordPageViewControllerWrapper()
//                    .environmentObject(routingCoordinator)
//        let hostingController = UIHostingController(rootView: swiftUIView)
//                
//                // Add the hosting controller's view to your view hierarchy
//                addChild(hostingController)
//                view.addSubview(hostingController.view)
//                hostingController.view.frame = view.bounds
//                hostingController.didMove(toParent: self)
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        setupTitleLabels()
        setupTopResultImage()
        setupFeedbackView()
        setupTopFirstView()
        setupOtherResultView()
        setupBottomView()
        setupTryAgainButton()
        setupFeedbackButton()
        setupMicButton()
    }

    private func bindViewModel() {
        if let topResult = viewModel.classificationResult.topResult {
            nameLabel.text = topResult.label.replacingOccurrences(of: "_", with: " ").capitalized
            nameLabel.font = UIFont(name: "SecularOne-Regular", size: 17)
            self.topResultImage.image = UIImage(named: "\(topResult.label.lowercased())Top")
        }

        let classifications = viewModel.classificationResult.classifications
        let customFont = UIFont.systemFont(ofSize: 14)
        
        if classifications.count > 1 {
            let secondResult = classifications[1]
            let formattedLabel = secondResult.label.replacingOccurrences(of: "_", with: " ").localizedCapitalized
            let attributedTitle = NSAttributedString(string: formattedLabel, attributes: [.font: customFont])
            self.firstOtherResult.setAttributedTitle(attributedTitle, for: .normal)
            self.firstOtherImage.image = UIImage(named: secondResult.label.lowercased())
        }
        if classifications.count > 2 {
            let thirdResult = classifications[2]
            let formattedLabel = thirdResult.label.replacingOccurrences(of: "_", with: " ").localizedCapitalized
            let attributedTitle = NSAttributedString(string: formattedLabel, attributes: [.font: customFont])
            self.secondOtherResult.setAttributedTitle(attributedTitle, for: .normal)
            self.secondOtherIMage.image = UIImage(named: thirdResult.label.lowercased())
        }
        if classifications.count > 3 {
            let fourthResult = classifications[3]
            let formattedLabel = fourthResult.label.replacingOccurrences(of: "_", with: " ").localizedCapitalized
            let attributedTitle = NSAttributedString(string: formattedLabel, attributes: [.font: customFont])
            self.thirdOtherResult.setAttributedTitle(attributedTitle, for: .normal)
            self.thirdOtherImage.image = UIImage(named: fourthResult.label.lowercased())
        }
        if classifications.count > 4 {
            let fifthResult = classifications[4]
            let formattedLabel = fifthResult.label.replacingOccurrences(of: "_", with: " ").localizedCapitalized
            let attributedTitle = NSAttributedString(string: formattedLabel, attributes: [.font: customFont])
            self.fourthOtherResult.setAttributedTitle(attributedTitle, for: .normal)
            self.fourthOtherImage.image = UIImage(named: fifthResult.label.lowercased())
        }

        subscribeToRecommendation(viewModel.$recommendation1)
    }

//    @IBAction func tryAgainButton(_ sender: Any) {
//        DispatchQueue.main.async {
//            let recordVC = RecordPageViewController()
//            self.navigationController?.popViewController(animated: true)
//            self.navigationController?.pushViewController(recordVC, animated: true)
//            self.viewModel.shouldNavigateRecord = false
//        }
//    }

    @IBAction func firstOtherCauses(_ sender: Any) {
        subscribeToRecommendation(viewModel.$recommendation2)
    }

    @IBAction func secondOtherCauses(_ sender: Any) {
        subscribeToRecommendation(viewModel.$recommendation3)
    }

    @IBAction func thirdOtherCauses(_ sender: Any) {
        subscribeToRecommendation(viewModel.$recommendation4)
    }

    @IBAction func fourthOtherCauses(_ sender: Any) {
        subscribeToRecommendation(viewModel.$recommendation5)
    }

    private func subscribeToRecommendation(_ publisher: Published<RecommendationEntity?>.Publisher) {
        // Cancel any existing subscription to avoid overlapping
        currentPublisher?.cancel()

        // Subscribe to the new publisher
        currentPublisher = publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recommendation in
                guard let recommendation = recommendation else { return }
                self?.descriptionLabel.text = recommendation.description
            }
//        currentPublisher?.cancel()
    }

    private func setupTitleLabels(){
        for label in titleLabels {
            label.font = UIFont(name: "SecularOne-Regular", size: 17)
        }
    }
    private func setupTopFirstView() {
        topFirstView.layer.cornerRadius = 12.0
    }

    private func setupBottomView() {
        bottomView.layer.cornerRadius = 12.0
    }

    private func setupOtherResultView(){
        seeOtherResultView.layer.cornerRadius = 12.0
    }

    private func setupTryAgainButton(){
        // tryAgainButton.layer.cornerRadius = 21
    }

    private func setupTopResultImage(){
        bgView.layer.cornerRadius = bgView.frame.size.width / 2
        bgView.backgroundColor = .clear // Set your desired background color
        bgView.layer.borderColor = UIColor(resource: .midPurple).cgColor // Set border color
        bgView.layer.borderWidth = 5.0

        // Ensure the image view is in front of the circular background
        if let superview = topResultImage.superview {
            superview.insertSubview(bgView, belowSubview: topResultImage)
        }

        // Center the topResultImage within the circularBackgroundView
        topResultImage.center = bgView.center
    }

    private func setupFeedbackView(){
        feedbackView.layer.cornerRadius = 12.0
    }

    private func setupMicButton(){
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium)
        let micImage = UIImage(systemName: "mic.fill", withConfiguration: symbolConfig)
        micButton.setImage(micImage, for: .normal)
        micButton.sizeToFit()
        micButton.tintColor = .white
    }

    @IBAction func micRetryButton(_ sender: Any) {

    }
    
    private func setupFeedbackButton(){
        feedbackButton.layer.cornerRadius = 24.0
        feedbackButton.backgroundColor = .clear
        feedbackButton.layer.borderColor = UIColor(resource: .midPurple).cgColor
        feedbackButton.layer.borderWidth = 3.0
    }
}
