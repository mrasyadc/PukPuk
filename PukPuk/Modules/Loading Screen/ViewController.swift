//
//  ViewController.swift
//  Mini-3-Test
//
//  Created by Filbert Chai on 14/08/24.
//

import UIKit

class LoadingViewController: UIViewController {
    
    let progressLayer = CAShapeLayer()
    let backgroundLayer = CAShapeLayer()
    let innerCircleLayer = CAShapeLayer()
    let progressIcon = UIImageView()
    let completedLabel = UILabel()
    let analyzingLabel = UILabel()
    let titleLabel = UILabel()
    let textLabel = UILabel()
    let retryButton = UIButton(type: .system)
    let duration: TimeInterval = 10.0
    var timer: Timer?
    var currentPercentage: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupInnerCircle()
        setupCircularProgress()
        setupProgressIcon()
        setupCompletedLabel()
        setupAnalyzingLabel()
        setupTitleLabel()
        setupTextLabel()
        setupRetryButton()
        startProgressAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.handleCompletion()
        }
    }
    
    func setupInnerCircle() {
        let center = view.center
        let radius: CGFloat = 120
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        innerCircleLayer.path = circularPath.cgPath
        innerCircleLayer.fillColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(innerCircleLayer)
    }
    
    func setupCircularProgress() {
        let center = view.center
        let radius: CGFloat = 120
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 10
        backgroundLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(backgroundLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.darkGray.cgColor
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0
        view.layer.addSublayer(progressLayer)
    }
    
    func setupProgressIcon() {
        progressIcon.image = UIImage(named: "Image.png")
        progressIcon.contentMode = .scaleAspectFit
        progressIcon.tintColor = .black
        progressIcon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(progressIcon)
        
        NSLayoutConstraint.activate([
            progressIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15),
            progressIcon.widthAnchor.constraint(equalToConstant: 50),
            progressIcon.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupCompletedLabel() {
        completedLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        completedLabel.textColor = .black
        completedLabel.textAlignment = .center
        completedLabel.text = "Completed"
        completedLabel.isHidden = true
        completedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(completedLabel)
        
        NSLayoutConstraint.activate([
            completedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupAnalyzingLabel() {
        analyzingLabel.font = UIFont.systemFont(ofSize: 18)
        analyzingLabel.textColor = .black
        analyzingLabel.textAlignment = .center
        analyzingLabel.text = "Analyzing..."
        analyzingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(analyzingLabel)
        
        NSLayoutConstraint.activate([
            analyzingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            analyzingLabel.topAnchor.constraint(equalTo: progressIcon.bottomAnchor, constant: 20)
        ])
    }
    
    func setupTextLabel() {
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.text = "  Make sure your surrounding is quiet.  "
        textLabel.layer.borderColor = UIColor.black.cgColor
        textLabel.layer.borderWidth = 1.0
        textLabel.layer.cornerRadius = 5.0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: analyzingLabel.bottomAnchor, constant: 180)
        ])
    }
    
    func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "Let's hear what your baby wants."
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: progressIcon.bottomAnchor, constant: -250)
        ])
    }
    
    func setupRetryButton() {
        retryButton.setTitle("Retry", for: .normal)
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: analyzingLabel.bottomAnchor, constant: 250),
            retryButton.heightAnchor.constraint(equalToConstant: 44),
            retryButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        retryButton.isHidden = true
    }
    
    func startProgressAnimation() {
        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimation.toValue = 1.0
        progressAnimation.duration = duration
        progressAnimation.fillMode = .forwards
        progressAnimation.isRemovedOnCompletion = false
        progressLayer.add(progressAnimation, forKey: "progressAnim")
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePercentage), userInfo: nil, repeats: true)
    }
    
    @objc func updatePercentage() {
        currentPercentage += CGFloat(1.0 / duration * 0.1)
        let percentage = min(Int(currentPercentage * 100), 100)
        
        if percentage >= 100 {
            timer?.invalidate()
            timer = nil
            handleCompletion()
        }
    }
    
    func handleCompletion() {
        analyzingLabel.isHidden = true
        progressIcon.isHidden = true
        completedLabel.isHidden = false
        
        retryButton.isHidden = false
    }
    
    @objc func retryButtonTapped() {
        currentPercentage = 0
        analyzingLabel.isHidden = false
        analyzingLabel.text = "Analyzing..."
        progressIcon.isHidden = false
        completedLabel.isHidden = true
        retryButton.isHidden = true
        
        startProgressAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.handleCompletion()
        }
    }
}
