    //
    //  OnBoardingViewController.swift
    //  PukPuk
    //
    //  Created by Jason Susanto on 21/08/24.
    //

    import UIKit
    import SwiftUI

    // Model
    struct OnboardingPage: Equatable {
        let title: String
        let description: String
        let heroImage: UIImage
    }

    class OnBoardingViewController: UIViewController {
        
        var page: OnboardingPage!
//        var pageControl: UIPageControl!
        var nextButton: UIButton!
        let skipLabel = UILabel()
        var pages: [OnboardingPage]!
        var currentPageIndex: Int = 0
        var coordinator: RoutingCoordinator
        
        init(page: OnboardingPage, pages: [OnboardingPage], currentPageIndex: Int, coordinator: RoutingCoordinator) {
            self.page = page
            self.pages = pages
            self.currentPageIndex = currentPageIndex
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupView()
    //        setupPageControl()
            setupNextButton()
            updateNextButtonTitle()
        }
        
        private func setupView() {
            view.backgroundColor = UIColor(resource: .purple)
            setupBlobView()
            setupHeroView()
            setupBottomView()
            setupSkipLabelView()
        }
        
        func setupSkipLabelView() {
            skipLabel.text = "Skip"
            skipLabel.textColor = .black
            skipLabel.translatesAutoresizingMaskIntoConstraints = false
            skipLabel.font = UIFont(name: "SFCompact-Medium", size: 16)
            
            view.addSubview(skipLabel)
            
            NSLayoutConstraint.activate([
                skipLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.08),
                skipLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4.5),
            ])
        }
        
        func setupBlobView() {
            let leftTopBlob = UIImageView()
            leftTopBlob.image = UIImage(resource: .miniLeftBlub)
            leftTopBlob.contentMode = .scaleAspectFill
            leftTopBlob.translatesAutoresizingMaskIntoConstraints = false
            
            let rightTopBlob = UIImageView()
            rightTopBlob.image = UIImage(resource: .topRightBlub)
            rightTopBlob.contentMode = .scaleAspectFill
            rightTopBlob.translatesAutoresizingMaskIntoConstraints = false
            
            let miniBlob1 = UIImageView()
            miniBlob1.image = UIImage(resource: .miniBlub1)
            miniBlob1.contentMode = .scaleAspectFill
            miniBlob1.translatesAutoresizingMaskIntoConstraints = false
            
            let miniBlob2 = UIImageView()
            miniBlob2.image = UIImage(resource: .miniBlub1)
            miniBlob2.contentMode = .scaleAspectFill
            miniBlob2.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(rightTopBlob)
            view.addSubview(leftTopBlob)
            view.addSubview(miniBlob1)
            view.addSubview(miniBlob2)
            
            NSLayoutConstraint.activate([
                leftTopBlob.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
                leftTopBlob.topAnchor.constraint(equalTo: view.topAnchor, constant: -(UIScreen.main.bounds.height * 0.1)),
                
                rightTopBlob.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                rightTopBlob.topAnchor.constraint(equalTo: view.topAnchor, constant: -(UIScreen.main.bounds.height * 0.26)),
                rightTopBlob.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 20),
                
                miniBlob1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
                miniBlob1.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.178),
                miniBlob1.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4.5),
                
                miniBlob2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12),
                miniBlob2.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.335),
                miniBlob2.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1.5)
            ])
        }
        
        func setupHeroView() {
            let heroImage = UIImageView(image: page.heroImage)
            heroImage.contentMode = .scaleAspectFill
            heroImage.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(heroImage)
            
            NSLayoutConstraint.activate([
//                heroImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                heroImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                heroImage.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.225)
            ])
        }
        
        func setupBottomView() {
            let bottomView = UIView()
            bottomView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            view.addSubview(bottomView)
            
            let backgroundImageView = UIImageView(image: UIImage(resource: .bottomBlub))
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            bottomView.addSubview(backgroundImageView)
            
            // Send the image view to the back so that it acts as a background
            bottomView.sendSubviewToBack(backgroundImageView)
            
            // Add constraints to make the background image fill the entire bottomView
            NSLayoutConstraint.activate([
                backgroundImageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
                backgroundImageView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
                backgroundImageView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
            ])
            
            let titleLabel = UILabel()
            titleLabel.text = page.title
            titleLabel.font = UIFont(name: "SecularOne-Regular", size: 20)
            titleLabel.textAlignment = .center
            titleLabel.textColor = .black  // Adjusted for visibility over the image
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            bottomView.addSubview(titleLabel)
            
            let descriptionLabel = UILabel()
            let descriptionText = page.description
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3.5
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: paragraphStyle,
                .kern: -0.6 // Adjust this value to control the letter spacing
            ]
            
            let attributedText = NSAttributedString(string: descriptionText, attributes: attributes )
            descriptionLabel.attributedText = attributedText
            descriptionLabel.font = UIFont(name: "SFProRounded-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .black
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            bottomView.addSubview(descriptionLabel)
            
            // Set up constraints
            NSLayoutConstraint.activate([
                // TitleLabel constraints
                titleLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 65),
                titleLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
                
                // DescriptionLabel constraints
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
                descriptionLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 57),
                descriptionLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -58),
                descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomView.bottomAnchor, constant: -20)
            ])
        }
        
//        private func setupPageControl() {
//            pageControl = UIPageControl()
//            pageControl.translatesAutoresizingMaskIntoConstraints = false
//            pageControl.numberOfPages = pages.count
//            pageControl.currentPage = 0
//            pageControl.backgroundColor = .blue
//            view.addSubview(pageControl)
//            
//            NSLayoutConstraint.activate([
//                pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
//            ])
//        }
        
        @objc func nextBtnClicked() {
            if currentPageIndex < pages.count - 1 {
    //            pageControl.currentPage = currentPageIndex
                
                let nextPage = pages[currentPageIndex + 1]
                let nextVC = OnBoardingViewController(page: nextPage, pages: pages, currentPageIndex: currentPageIndex + 1, coordinator: coordinator)
                self.navigationController?.pushViewController(nextVC, animated: false)
            } else {
                print("GO TO COntent view")
                UserDefaults.standard.hasSeenOnboarding = true
                coordinator.push(page: .record)
            }
            updateNextButtonTitle()
        }
        
        func setupNextButton() {
            nextButton = UIButton()
            nextButton.setTitleColor(.white, for: .normal)
            
            let mediumFont = UIFont.systemFont(ofSize: 16, weight: .bold)
            let attributedTitle = NSAttributedString(string: "Next", attributes: [.font: mediumFont])
            nextButton.setAttributedTitle(attributedTitle, for: .normal)
            
            // Mengatur konfigurasi tombol
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = UIColor(resource: .purple)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            configuration.background.cornerRadius = .infinity
            
            // Terapkan konfigurasi
            nextButton.configuration = configuration
            
            // Menambahkan shadow hitam
            nextButton.layer.shadowColor = UIColor.black.cgColor
            nextButton.layer.shadowOffset = CGSize(width: 0, height: 3)
            nextButton.layer.shadowOpacity = 0.25
            nextButton.layer.shadowRadius = 4
            
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(nextButton)
            
            // Mengatur constraints untuk tombol
            NSLayoutConstraint.activate([
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -27),
                nextButton.heightAnchor.constraint(equalToConstant: 48),
                nextButton.widthAnchor.constraint(equalToConstant: 124)
            ])
            
            nextButton.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
        }
        
        func updateNextButtonTitle() {
            if currentPageIndex == pages.count - 1 {
                let mediumFont = UIFont.systemFont(ofSize: 16, weight: .bold)
                let attributedTitle = NSAttributedString(string: "Get Started", attributes: [.font: mediumFont])
                
                nextButton.setAttributedTitle(attributedTitle, for: .normal)
                skipLabel.text = ""
            } else {
                let mediumFont = UIFont.systemFont(ofSize: 16, weight: .bold)
                let attributedTitle = NSAttributedString(string: "Next", attributes: [.font: mediumFont])
                
                nextButton.setAttributedTitle(attributedTitle, for: .normal)
            }
        }
    }

    struct OnBoardingViewControllerRepresentable: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = OnBoardingViewController
        
        var pages: [OnboardingPage]
        @Binding var currentPageIndex: Int
        var coordinator: RoutingCoordinator
        
        func makeUIViewController(context: Context) -> OnBoardingViewController {
            let viewController = OnBoardingViewController(page: pages[currentPageIndex], pages: pages, currentPageIndex: currentPageIndex, coordinator: coordinator)
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: OnBoardingViewController, context: Context) {
            
            uiViewController.currentPageIndex = currentPageIndex
            uiViewController.updateNextButtonTitle()
    //        uiViewController.pageControl.currentPage = currentPageIndex
        }
    }


