//
//  ResultsPageViewController.swift
//  App
//
//  Created by Jason Susanto on 28/08/24.
//

import UIKit
import SwiftUI
import Combine

class ResultsPageViewController: UIViewController {
    
    var viewModel: ResultPageViewModel!
    var onTryAgainTapped:  (() -> Void)?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var topDesc: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    
    @IBOutlet weak var recommendationTable: UITableView!
    @IBOutlet weak var possibleTable: UITableView!
    
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var feedbackTitle: UILabel!
    @IBOutlet weak var feedbackDesc: UILabel!
    @IBOutlet weak var feedBackButton: UIButton!
    
    @IBOutlet weak var recommendationTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var possibleTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var micButton: UIButton!
    var recommendationData: [(title: String, description: String)] = [
        ("Recommendation 1", "Short description"),
        ("Recommendation 2", "This is a longer description that will require more space in the cell"),
        ("Recommendation 1", "Short description"),
        ("Recommendation 3", "Another description with varying length to demonstrate dynamic cell heights")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTopView()
        setupTable()
        setupFeedbackView()
        updateTableHeights()
        setupMicButton()
        
        bindViewModel()
    }
    
    @IBAction func clickedMicButton(_ sender: UIButton) {
        onTryAgainTapped?()
    }
    
    private func bindViewModel() {
        if let topResult = viewModel.classificationResult.topResult {
            topTitle.text = topResult.label.replacingOccurrences(of: "-", with: " ").capitalized
            topTitle.font = UIFont(name: "SecularOne-Regular", size: 20)
            iconView.image = UIImage(named: "\(topResult.label.lowercased())Top")
            topDesc.text = viewModel.selectedRecommendation?.description ?? "No description available"
            topDesc.font = UIFont.systemFont(ofSize: 12)
        }
        
        possibleTable.reloadData()
        recommendationTable.reloadData()
    }
    
    func setupView() {
        var imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(resource: .resultBg)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        
        horizontalStackView.spacing = 12
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
    }
    
    func setupTopView() {
        iconView.image = UIImage(resource: .hungryTop)
        topView.layer.cornerRadius = 12
        topView.backgroundColor = UIColor(.white)
        topView.alpha = 1.0
        topTitle.font = UIFont(name: "SecularOne-Regular", size: 20)
    }
    
    func setupTable() {
        possibleTable.register(
            CausesTableViewCell.nib(),
            forCellReuseIdentifier: CausesTableViewCell.identifier
        )
        
        recommendationTable.register(
            RecommendationTableViewCell.nib(),
            forCellReuseIdentifier: RecommendationTableViewCell.identifier)
        
        possibleTable.dataSource = self
        possibleTable.delegate = self
        possibleTable.separatorStyle = .none
        possibleTable.isScrollEnabled = false
        possibleTable.layer.cornerRadius = 12.0
        
        recommendationTable.dataSource = self
        recommendationTable.delegate = self
        recommendationTable.isScrollEnabled = false
        recommendationTable.separatorStyle = .none
        recommendationTable.layer.cornerRadius = 12.0
                
        possibleTable.sectionHeaderTopPadding = 5
        recommendationTable.sectionHeaderTopPadding = 5
    }
    
    func setupFeedbackView() {
        feedbackView.layer.cornerRadius = 12
        feedbackView.backgroundColor = .white
        
        feedbackTitle.text = "Your Feedback"
        feedbackTitle.font = UIFont(name: "SecularOne-Regular", size: 16)
        
        feedbackDesc.text = "Help us improve our app so that we can give more accurate result through your feedback."
        feedbackDesc.font = feedbackDesc.font.withSize(13)
        
        // Configure button
        feedBackButton.setTitle("Write Feedback", for: .normal)
        feedBackButton.setTitleColor(UIColor(resource: .lightPurple), for: .normal)
        feedBackButton.backgroundColor = .white
        
        feedBackButton.layoutIfNeeded()
        feedBackButton.layer.cornerRadius = feedBackButton.bounds.height / 2
        
        feedBackButton.layer.borderColor = UIColor(resource: .lightPurple).cgColor
        feedBackButton.layer.borderWidth = 2
        feedBackButton.clipsToBounds = true
        
        // Add shadow
        feedBackButton.layer.shadowColor = UIColor.black.cgColor
        feedBackButton.layer.shadowOpacity = 0.25
        feedBackButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        feedBackButton.layer.shadowRadius = 4
        feedBackButton.layer.masksToBounds = false
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeights()
    }
    
    func updateTableHeights() {
        // Ensure layout is up-to-date
        view.layoutIfNeeded()

        possibleTable.layoutIfNeeded()
        recommendationTable.layoutIfNeeded()

        let possibleTableHeight = possibleTable.contentSize.height
        let recommendationTableHeight = recommendationTable.contentSize.height

        // Update height constraint for recommendation table
        recommendationTableHeightConstraint.constant = recommendationTableHeight + 8
        possibleTableHeightConstraint.constant = possibleTableHeight + 8

        // Force layout update
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    func setupMicButton() {
        let buttonSize: CGFloat = 91
        micButton.setTitle("", for: .normal)
        let largeMicImage = UIImage(systemName: "mic")?.withTintColor(.white, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 25))
        micButton.setImage(largeMicImage, for: .normal)

        var configuration = UIButton.Configuration.filled()
        configuration.title = "Button"
        configuration.baseBackgroundColor = UIColor.systemPink
        configuration.contentInsets = NSDirectionalEdgeInsets(
          top: 20,
          leading: 20,
          bottom: 20,
          trailing: 20
        )
        
        if let backgroundImage = UIImage(named: "micButtonbg") {
            configuration.background.image = backgroundImage
            configuration.background.imageContentMode = .scaleAspectFill
        }
        
        configuration.background.cornerRadius = micButton.bounds.width * 0.5
        configuration.cornerStyle = .fixed

        micButton.configuration = configuration
    }

}

extension ResultsPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == possibleTable ? 4 : viewModel.selectedRecommendation!.steps.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == possibleTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: CausesTableViewCell.identifier, for: indexPath) as! CausesTableViewCell
            let classification = viewModel.classificationResult.classifications[indexPath.row + 1]
            let rank = getOrdinal(for: indexPath.row+2)
            let label = ClassificationResult(label: classification.label)?.rawValue.replacingOccurrences(of: "_", with: " ").capitalized ?? classification.label
            
            cell.configure(causeName: label, rank: rank)
            return cell
        } else if tableView == recommendationTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationTableViewCell.identifier, for: indexPath) as! RecommendationTableViewCell
            let recommendation = viewModel.selectedRecommendation!.steps[indexPath.row]
            cell.configure(title: recommendation.title, desc: recommendation.desc)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == possibleTable {
            let classification = viewModel.classificationResult.classifications[indexPath.row + 1]
            if let selectedClassification = ClassificationResult(label: classification.label) {
                viewModel.updateSelectedRecommendation(for: selectedClassification)
                recommendationTable.reloadData()
                DispatchQueue.main.async {
                    self.updateTableHeights()
                }
            }
        }
    }
    
    private func getOrdinal(for number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)th"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white

        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 16, y: 10, width: tableView.frame.width-16, height: 12)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = tableView == possibleTable ? "Other Possible Causes" : "Recommendations"
        
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

struct ResultsPageViewControllerRepresentable: UIViewControllerRepresentable{
    typealias UIViewControllerType = ResultsPageViewController
    
    func makeUIViewController(context: Context) -> ResultsPageViewController {
        let viewController = ResultsPageViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ResultsPageViewController, context: Context) {
        // Update
    }
}
