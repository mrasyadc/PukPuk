//
//  NoResultViewController.swift
//  PukPuk
//
//  Created by Jason Susanto on 20/08/24.
//

import UIKit
import SwiftUI

class NoResultViewController: UIViewController {

    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    var onTryAgainTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        changeBackgorund()
        setupTryButton()
        setupImage()
    }
    
    func changeBackgorund(){
        view.backgroundColor = UIColor(resource: .purple)
    }
    
    func setupTryButton() {
        tryAgainButton.setTitle("Try again", for: .normal)
        tryAgainButton.setTitleColor(.red, for: .normal)
        tryAgainButton.backgroundColor = .white
        tryAgainButton.layer.cornerRadius = 8.0
        tryAgainButton.configuration?.titlePadding = 18.0
    }
    
    func setupImage() {
        imageHero.image = UIImage(resource: .sadRobo)
        imageHero.contentMode = .scaleAspectFit
        imageHero.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageHero.heightAnchor.constraint(lessThanOrEqualToConstant: 170),
            imageHero.widthAnchor.constraint(lessThanOrEqualTo: imageHero.heightAnchor),
            imageHero.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @IBAction func clickTryAgainButton(_ sender: Any) {
        onTryAgainTapped?()
    }
}

struct NoResultViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = NoResultViewController
    
    func makeUIViewController(context: Context) -> NoResultViewController {
        let viewController = NoResultViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: NoResultViewController, context: Context) {
        // if changed.
    }
}

