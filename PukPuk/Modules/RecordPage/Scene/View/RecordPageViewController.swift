//
//  RecordPageViewController.swift
//  PukPuk
//
//  Created by Jason Susanto on 14/08/24.
//

import UIKit
import SwiftUI

struct RecordPageViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = RecordPageViewController
    
    func makeUIViewController(context: Context) -> RecordPageViewController {
        return RecordPageViewController()
    }
    
    func updateUIViewController(_ uiViewController: RecordPageViewController, context: Context) {
        // update view controlller if needed.
    }
}

class RecordPageViewController: UIViewController {
    
    private var viewModel: RecordPageViewModel!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var hStackInfo: UIStackView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderLabel()
        setupRecordButton()
        setupInfoLabel()
    }
    
    private func setupHeaderLabel(){
        headerLabel.text = "Let's hear what your baby wants"
        headerLabel.textAlignment = .center
    }
    
    private func setupRecordButton(){
        let image = UIImage(resource: .babyIcon)
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.setImage(image, for: .normal)
        recordButton.backgroundColor = .systemGray3
        
        recordButton.configuration = UIButton.Configuration.plain()
        recordButton.configuration?.imagePlacement = .top
        recordButton.configuration?.imagePadding = 15
        recordButton.configuration?.baseForegroundColor = .black
        
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
    }
    
    private func setupInfoLabel() {
        infoImage.image = UIImage(resource: .infoIcon)
        labelInfo.text = "Lorem ipsum dolor sit amet, consec tetur"
        
        labelInfo.numberOfLines = 0
        labelInfo.font = labelInfo.font.withSize(14)
        
        hStackInfo.axis = .horizontal
        hStackInfo.alignment = .center
        hStackInfo.distribution = .fill
        hStackInfo.spacing = 8 // Jarak antara image dan label
        
        // Mengatur ukuran infoImage
        infoImage.contentMode = .scaleAspectFit
        infoImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        infoImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let screenWidth = UIScreen.main.bounds.width
        let infoSize = screenWidth * 0.65
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(hStackInfo)
        view.addSubview(containerView)
        
        // setting posisi containerView
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            containerView.widthAnchor.constraint(equalToConstant: infoSize),
            containerView.heightAnchor.constraint(equalToConstant: 60)
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
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        containerView.layer.cornerRadius = 8
    }
    
    @IBAction func onClickRecordButton(_ sender: UIButton) {
        let pulse = PulseAnimation(numberOfPulse: Float.infinity, radius: 1200, postion: sender.center)
        pulse.animationDuration = 1.0
        pulse.backgroundColor = Color.gray.cgColor
        self.view.layer.insertSublayer(pulse, below: sender.layer)
        
        recordButton.setTitle("Recording...", for: .normal)
    }
    
}
