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
    @State private var isRecording = false
    private var lastTriggerTime: Date?
    
    var viewModel: RecordPageViewModel!
    var routingCoordinator: RoutingCoordinator!
    private var ringLayer: CAShapeLayer?
    
    private let idleImage = UIImage(resource: .babyIcon)
    private let recordingImage = UIImage(resource: .micIcon) // Atau gambar custom Anda
    
    private let recordButton = UIButton()
    private let headerLabel = UILabel()
    
    private var cancellables = Set<AnyCancellable>()
    var pulseLayers = [CAShapeLayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundColor()
        setupHeaderLabel()
        setupRecordButton()
        setupLayoutConstraints()
        setupBabyAsset()
        
        bindViewModel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(startRecording), name: Notification.Name("StartRecording"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopRecording), name: Notification.Name("StopRecording"), object: nil)
    }
    
    @objc private func startRecording() {
        guard canPerformAction() else { return }
        if !isRecording {
            onClickRecordButton()
        }
    }

    @objc private func stopRecording() {
        guard canPerformAction() else { return }
        if isRecording {
            onClickRecordButton()
        }
    }
        
    private func canPerformAction() -> Bool {
        let currentTime = Date()
        if let lastTime = lastTriggerTime, currentTime.timeIntervalSince(lastTime) < 1.0 {
            return false
        }
        lastTriggerTime = currentTime
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func changeBackgroundColor() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(resource: .recordBg)
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
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
        headerLabel.textColor = UIColor(resource: .darkPurple)
        headerLabel.font = UIFont(name: "SecularOne-Regular", size: 20)
        headerLabel.textAlignment = .center
        view.addSubview(headerLabel)
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
        let buttonSize = screenWidth * 0.65
        recordButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        recordButton.layer.cornerRadius = buttonSize / 2
        recordButton.clipsToBounds = true
        
        recordButton.layer.shadowColor = UIColor.white.cgColor
        recordButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        recordButton.layer.shadowOpacity = 0.8
        recordButton.layer.cornerRadius = buttonSize / 2
        recordButton.layer.shadowRadius = 20
        recordButton.layer.masksToBounds = false
        
        recordButton.addTarget(self, action: #selector(handleRecordButtonClick), for: .touchUpInside) // Menetapkan target

        // add button to view.
        view.addSubview(recordButton)
        
        // Add inner shadow
        addInnerShadow(to: recordButton, with: UIScreen.main.bounds.width * 0.65)
    }
    
    private func addInnerShadow(to button: UIButton, with size: CGFloat) {
        let innerShadow = CALayer()
        innerShadow.frame = button.bounds
        innerShadow.cornerRadius = size / 2
        innerShadow.backgroundColor = UIColor.clear.cgColor
        
        // Membuat shadow
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 0)
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 10
        
        // Menggunakan mask untuk menciptakan efek inner shadow
        let maskLayer = CAShapeLayer()
        let cutoutPath = UIBezierPath(ovalIn: innerShadow.bounds)
        let fullPath = UIBezierPath(rect: innerShadow.bounds)
        
        fullPath.append(cutoutPath)
        maskLayer.path = fullPath.cgPath
        maskLayer.fillRule = .evenOdd
        
        innerShadow.mask = maskLayer
        
        button.layer.addSublayer(innerShadow)
    }
    
    private func setupLayoutConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        recordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Constraints for headerLabel
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerLabel.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -(UIScreen.main.bounds.height * 0.15)),

            // Constraints for recordButton
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),

            // Set button size (width and height)
            recordButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65),
            recordButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65)
        ])
    }
    
    private func setupBabyAsset() {
        let babyImage = UIImageView()
        
        let babyImages: [UIImage] = [
            UIImage(resource: .baby1),
            UIImage(resource: .baby2)
        ]
        
        // Pilih gambar secara acak
        let selectedImage = babyImages.randomElement()!
        babyImage.image = selectedImage
        babyImage.contentMode = .scaleAspectFill
        babyImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(babyImage)
        
        // Buat constraint berdasarkan gambar yang dipilih
        if selectedImage == UIImage(resource: .baby1) {
            NSLayoutConstraint.activate([
                babyImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.55),
                babyImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.75),
                babyImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23)
            ])
        } else {
            NSLayoutConstraint.activate([
                babyImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.60),
                babyImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.75),
                babyImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
            ])
        }
    }
    
//    @IBAction func onClickRecordButton(_ sender: UIButton) {
//        if viewModel.recordingState == .idle {
//            viewModel.didTapRecordButton.send(())
//        } else if viewModel.recordingState == .recording {
//            viewModel.didStopRecording.send(())
//        }
//    }
    
    @objc func handleRecordButtonClick() {
        onClickRecordButton()
    }
    
    func onClickRecordButton() {
        if viewModel.recordingState == .idle {
            viewModel.didTapRecordButton.send(())
        } else if viewModel.recordingState == .recording {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    if shouldNavigate {
                        self?.navigateToResultPage()
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.$shouldNavigateToNoResult
            .sink { [weak self] shouldNavigate in
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    if shouldNavigate {
                        self?.navigateToNoResultPage()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func navigateToResultPage() {
        guard let result = viewModel.classificationResult else { return }
        
        DispatchQueue.main.async {
            let resultCoordinator = ResultPageCoordinator(
                navigationController: self.navigationController!,
                classificationResult: result,
                onTryAgainTapped: { [weak self] in
                    self?.navigationController?.popToRootViewController(animated: true)
                    self?.resetToIdleState()
                    self?.onClickRecordButton()
                }
            )
            resultCoordinator.start()
        }
    }
    
    private func navigateToNoResultPage() {
        DispatchQueue.main.async {
            let noResultVC = NoResultViewController()
            noResultVC.onTryAgainTapped = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                self?.resetToIdleState()
            }
            self.navigationController?.pushViewController(noResultVC, animated: true)
            self.viewModel.shouldNavigateToNoResult = false
        }
    }
    
    private func resetToIdleState() {
        viewModel.resetToIdle()
        updateRecordButton(for: .idle)
    }
    
    private func updateRecordButton(for state: AudioRecordingState) {
        let title = stateTextRecordConfiguration(for: state)
        let boldFont = UIFont.boldSystemFont(ofSize: 16.0)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        recordButton.setAttributedTitle(attributedTitle, for: .normal)
        
//        MARK: bisa ke viewModel, viewController hanya View

        switch state {
        case .idle:
            recordButton.setImage(idleImage, for: .normal)
            stopImpulseAnimation()
            stopRingBarAnimation()
        case .recording:
            let resizedRecordingImage = recordingImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))
            recordButton.setImage(resizedRecordingImage, for: .normal)
            startImpulseAnimation()
            stopRingBarAnimation()
        case .analyzing:
            recordButton.setImage(idleImage, for: .normal)
            stopImpulseAnimation()
            startRingBarAnimation()
        }
    }

    // MARK: - Animation

    private func startRingBarAnimation() {
        // Hapus ringLayer sebelumnya jika ada
        ringLayer?.removeFromSuperlayer()

        let newRingLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: recordButton.center, radius: recordButton.bounds.width / 2 + 5, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        newRingLayer.path = circularPath.cgPath
        newRingLayer.strokeColor = UIColor(resource: .midPurple).cgColor
        newRingLayer.fillColor = UIColor.clear.cgColor
        newRingLayer.lineWidth = 8
        newRingLayer.lineCap = .round
        newRingLayer.strokeEnd = 0
        
        view.layer.addSublayer(newRingLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 6
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        newRingLayer.add(animation, forKey: "ringAnimation")
        ringLayer = newRingLayer
    }
    
    private func stopRingBarAnimation() {
        ringLayer?.removeFromSuperlayer()
        ringLayer = nil
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
