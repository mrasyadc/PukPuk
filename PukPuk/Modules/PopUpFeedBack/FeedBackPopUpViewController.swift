//
//  FeedBackPopUpViewController.swift
//  App
//
//  Created by Jason Susanto on 28/08/24.
//

import UIKit

class FeedBackPopUpViewController: UIViewController {

    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var feedBackTableList: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    
    let feedBackItem: [String] = ["Tired", "Discomfort", "Hungry", "Burping", "Belly Pain", "Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        setupUI()
        setupTable()
    }
    
    @IBAction func submitButonAction(_ sender: UIButton) {
        hide()
    }
    
    init() {
        super.init(nibName: "FeedBackPopUpViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
    }
    
    func setupUI(){
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = UIColor(resource: .lightLightPurple)
        
        reviewTitle.text = "What was the specific reason?"
        reviewTitle.font = UIFont(name: "SecularOne-Regular", size: 16)
        
        setupSubmitButton()
    }
    
    func setupSubmitButton(){
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 24
        
        // Menambahkan shadow dengan background hitam
        submitButton.layer.shadowColor = UIColor.black.cgColor
        submitButton.layer.shadowOpacity = 0.25
        submitButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        submitButton.layer.shadowRadius = 4
        submitButton.layer.masksToBounds = false
        
        var configuration = UIButton.Configuration.filled()
        if let backgroundImage = UIImage(named: "submitBg") {
            configuration.background.image = backgroundImage
            configuration.background.imageContentMode = .scaleAspectFill
        }
        configuration.baseBackgroundColor = .clear
        configuration.title = "Submit"
        
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "SecularOne-Regular", size: 14)
            return outgoing
        }
        
        configuration.background.cornerRadius = submitButton.bounds.width * 0.5
        configuration.cornerStyle = .fixed
        
        submitButton.configuration = configuration
    }

    
    func setupTable(){
        feedBackTableList.register(
            FeedbackTableViewCell.nib(),
            forCellReuseIdentifier: FeedbackTableViewCell.identifier
        )
        
        feedBackTableList.delegate = self
        feedBackTableList.dataSource = self
        feedBackTableList.backgroundColor = .clear
        feedBackTableList.isScrollEnabled = false
        feedBackTableList.separatorStyle = .none
    }
    
    func appear(sender: ResultsPageViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}

extension FeedBackPopUpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedBackItem.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackTableViewCell.identifier, for: indexPath) as! FeedbackTableViewCell
        cell.configure(label: feedBackItem[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    
}
