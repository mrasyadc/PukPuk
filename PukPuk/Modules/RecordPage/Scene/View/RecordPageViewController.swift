//
//  RecordPageViewController.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import Combine
import SwiftUI
import UIKit

struct RecordPageViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    @EnvironmentObject var routingCoordinator: RoutingCoordinator
    
    func makeUIViewController(context: Context) -> UINavigationController {
//        return RecordPageViewController()
        let navigationController = UINavigationController()
        let coordinator = RecordPageCoordinator(navigationController: navigationController, routingCoordinator: routingCoordinator)
        coordinator.start()
        navigationController.setNavigationBarHidden(true, animated: true)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // update view controlller if needed.
    }
}

class RecordPageViewController: UIViewController {
    var viewModel: RecordPageViewModel!
    var routingCoordinator: RoutingCoordinator!

    @IBOutlet var recordButton: UIButton!
    @IBOutlet var infoImage: UIImageView!
    @IBOutlet var labelInfo: UILabel!
    @IBOutlet var hStackInfo: UIStackView!
    @IBOutlet var headerLabel: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    var pulseLayers = [CAShapeLayer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundColor()
        setupHeaderLabel()
        setupRecordButton()
        setupInfoLabel()
        
        bindViewModel()
    }
    
    private func changeBackgroundColor() {
        view.backgroundColor = UIColor(resource: .purple)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(resource: .purple).cgColor]
        
        gradientLayer.type = .radial
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        // hardcode setting gradient :(
        gradientLayer.endPoint = CGPoint(x: 0.92, y: 0.69)

        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.frame
    }
    
    private func setupHeaderLabel() {
        headerLabel.text = "Let's hear what your baby wants"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        headerLabel.textAlignment = .center
    }
    
    private func setupRecordButton() {
        let image = UIImage(resource: .babyIcon)
        recordButton.setTitle("Tap to Record", for: .normal)

        let boldFont = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont
        ]
        let attributedTitle = NSAttributedString(string: "Tap to Record", attributes: attributes)
        recordButton.setAttributedTitle(attributedTitle, for: .normal)
        
        recordButton.setImage(image, for: .normal)
        recordButton.backgroundColor = UIColor(resource: .purple)
        
        recordButton.configuration = UIButton.Configuration.plain()
        recordButton.configuration?.imagePlacement = .top
        recordButton.configuration?.imagePadding = 15
        recordButton.configuration?.baseForegroundColor = .white
        
        // Mengatur ukuran button.
        let screenWidth = UIScreen.main.bounds.width
        let buttonSize = screenWidth * 0.60
        recordButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        recordButton.layer.cornerRadius = buttonSize / 2
        recordButton.clipsToBounds = true
        
        // atur alignment ke tengah
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        recordButton.addTarget(self, action: #selector(onClickRecordButton), for: .touchUpInside)
    }
    
    private func setupInfoLabel() {
        infoImage.image = UIImage(systemName: "info.circle")
        infoImage.tintColor = .black
        
        // TODO: INI HARUS DIUBAH NNT JANGAN HARDCODE
        labelInfo.text = "To ensure accurate analysis, please avoid any background noise or disturbances while recording your baby's cry."
        
        labelInfo.numberOfLines = 0
        labelInfo.font = labelInfo.font.withSize(12)
        labelInfo.textColor = .black
        
        hStackInfo.axis = .horizontal
        hStackInfo.alignment = .leading
        hStackInfo.distribution = .fill
        hStackInfo.spacing = 8 // Jarak antara image dan label
        
        hStackInfo.isLayoutMarginsRelativeArrangement = true
        hStackInfo.layoutMargins = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        
        // Mengatur ukuran infoImage
        infoImage.contentMode = .scaleAspectFit
        infoImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        infoImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let screenWidth = UIScreen.main.bounds.width
        let infoSize = screenWidth * 0.80
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.addSubview(hStackInfo)
        view.addSubview(containerView)
        
        // setting posisi containerView
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            containerView.widthAnchor.constraint(equalToConstant: infoSize)
        ])
        
        // Setting posisi hstacInfo
        NSLayoutConstraint.activate([
            hStackInfo.topAnchor.constraint(equalTo: containerView.topAnchor),
            hStackInfo.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            hStackInfo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            hStackInfo.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
        
        // Menambahkan border ke containerView
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor(resource: .darkPurple).cgColor
        containerView.layer.cornerRadius = 8
    }
    
    @IBAction func onClickRecordButton(_ sender: UIButton) {
        if viewModel.recordingState == .idle {
            viewModel.didTapRecordButton.send(())
        } else {
            viewModel.didStopRecording.send(())
        }
    }
    
    // melakukan bind perubahan state recording dari ViewModel ke UI tombol recording
    private func bindViewModel() {
        viewModel.$recordingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateRecordButton(for: state)
            }
            .store(in: &cancellables)
        
        viewModel.$shouldNavigateToResult
            .sink { [weak self] shouldNavigate in
                if shouldNavigate {
                    self?.navigateToResultPage()
                }
            }
            .store(in: &cancellables)
    }
    
    private func navigateToResultPage() {
        guard let result = viewModel.classificationResult else { return }

        DispatchQueue.main.async {
            let resultCoordinator = ResultPageCoordinator(navigationController: self.navigationController!, classificationResult: result)
            resultCoordinator.start()
        }
    }
    
    private func updateRecordButton(for state: AudioRecordingState) {
        let title = stateTextRecordConfiguration(for: state)
        let boldFont = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        recordButton.setAttributedTitle(attributedTitle, for: .normal)
        
        switch state {
        case .idle:
            stopImpulseAnimation()
        case .recording:
            startImpulseAnimation()
        case .analyzing:
            stopImpulseAnimation()
        }
    }

    private func stateTextRecordConfiguration(for state: AudioRecordingState) -> String {
        switch state {
        case .idle:
            return "Tap to Record"
        case .recording:
            return "Recording..."
        case .analyzing:
            return "Analyzing..."
        }
    }
    
    private func createFirstImpulseAnimation() {
        let pulseLayer = CAShapeLayer()
        pulseLayer.bounds = CGRect(x: 0, y: 0, width: recordButton.bounds.width, height: recordButton.bounds.height)
        pulseLayer.position = recordButton.center
        pulseLayer.path = UIBezierPath(ovalIn: pulseLayer.bounds).cgPath
        pulseLayer.fillColor = UIColor.systemGray6.cgColor
        pulseLayer.strokeColor = UIColor(resource: .purple).cgColor
        pulseLayer.lineWidth = 2
        pulseLayer.opacity = 0
        
        view.layer.insertSublayer(pulseLayer, below: recordButton.layer)
        pulseLayers.append(pulseLayer)
        
        let animation = CAAnimationGroup()
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.4
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [0, 0.5, 0]
        opacityAnimation.keyTimes = [0, 0.5, 1]
        
        animation.animations = [scaleAnimation, opacityAnimation]
        
        pulseLayer.add(animation, forKey: "pulseFirst")
    }
    
    private func createSecondImpulseAnimation() {
        let pulseLayer = CAShapeLayer()
        pulseLayer.bounds = CGRect(x: 0, y: 0, width: recordButton.bounds.width, height: recordButton.bounds.height)
        pulseLayer.position = recordButton.center
        pulseLayer.path = UIBezierPath(ovalIn: pulseLayer.bounds).cgPath
        pulseLayer.fillColor = UIColor.systemGray5.cgColor
        pulseLayer.strokeColor = UIColor(resource: .purple).cgColor
        pulseLayer.lineWidth = 2
        pulseLayer.opacity = 0
        
        view.layer.insertSublayer(pulseLayer, below: recordButton.layer)
        pulseLayers.append(pulseLayer)
        
        let animation = CAAnimationGroup()
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.8
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [0, 0.5, 0]
        opacityAnimation.keyTimes = [0, 0.5, 1]
        
        animation.animations = [scaleAnimation, opacityAnimation]
        
        pulseLayer.add(animation, forKey: "pulseSecond")
    }
    
    private func startImpulseAnimation() {
        stopImpulseAnimation()
        createFirstImpulseAnimation()
        createSecondImpulseAnimation()
    }

    private func stopImpulseAnimation() {
        for layer in pulseLayers {
            layer.removeFromSuperlayer()
        }
        pulseLayers.removeAll()
    }
}
