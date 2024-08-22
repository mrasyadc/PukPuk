//
//  OnboardingContainerViewController.swift
//  PukPuk
//
//  Created by Jason Susanto on 21/08/24.


//import UIKit
//import SwiftUI
//
//class OnboardingContainerViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
//
//    let pages: [OnboardingPage] = [
//        OnboardingPage(title: "Understand your baby’s world", description: "Record your baby’s cry and let Pukpuk identify it. For accurate analysis, avoid background noise or disturbances while recording your baby's cry.", heroImage: UIImage(resource: .iconHero1)),
//        OnboardingPage(title: "Learn from your baby's cry", description: "Understand your baby's needs by analyzing the patterns in their cry.", heroImage: UIImage(resource: .iconHero2)),
//        OnboardingPage(title: "Track your baby's progress", description: "Monitor your baby's development with detailed reports and insights.", heroImage: UIImage(resource: .iconHero3))
//    ]
//    
//    var currentIndex = 0
//    var pageControl = UIPageControl()
//    var coordinator: RoutingCoordinator
//    
//    init(coordinator: RoutingCoordinator) { // Modifikasi initializer
//         self.coordinator = coordinator
//         super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//     }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        delegate = self
//        dataSource = self
//
//        setupPageControl()
//        
//        if let firstPage = viewControllerAtIndex(0) {
//            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
//            pageControl.currentPage = 0
//        }
//    }
//
//    func setupPageControl() {
//        pageControl.numberOfPages = pages.count
//        pageControl.currentPage = 0
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
//        view.addSubview(pageControl)
//        
//        NSLayoutConstraint.activate([
//            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
//    
//    @objc func pageControlTapped(_ sender: UIPageControl) {
//        let newIndex = sender.currentPage
//        
//        if newIndex != currentIndex {
//            let direction: UIPageViewController.NavigationDirection = newIndex > currentIndex ? .forward : .reverse
//            if let nextVC = viewControllerAtIndex(newIndex) {
//                setViewControllers([nextVC], direction: direction, animated: true, completion: nil)
//                currentIndex = newIndex
//            }
//        }
//    }
//    
//    func viewControllerAtIndex(_ index: Int) -> OnBoardingViewController? {
//        guard index >= 0 && index < pages.count else { return nil }
//        let pageVC = OnBoardingViewController(page: pages[index], pages: pages, currentPageIndex: index, coordinator: coordinator)
//        return pageVC
//    }
//
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        let currentVC = viewController as! OnBoardingViewController
//        var index = pages.firstIndex(of: currentVC.page) ?? 0
//        index -= 1
//        return viewControllerAtIndex(index)
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let currentVC = viewController as! OnBoardingViewController
//        var index = pages.firstIndex(of: currentVC.page) ?? 0
//        index += 1
//        return viewControllerAtIndex(index)
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if completed {
//            if let currentVC = viewControllers?.first as? OnBoardingViewController {
//                currentIndex = currentVC.currentPageIndex
//                pageControl.currentPage = currentIndex
//            }
//        }
//    }
//}
