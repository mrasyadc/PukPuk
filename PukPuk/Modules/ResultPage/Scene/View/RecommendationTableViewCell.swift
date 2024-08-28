//
//  RecommendationTableViewCell.swift
//  App
//
//  Created by Jason Susanto on 22/08/24.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
    
    static let identifier = "RecommendationTableViewCell"

    static func nib() -> UINib {
      return UINib(nibName: "RecommendationTableViewCell", bundle: nil)
    }
    
    public func configure(title: String, desc: String) {
        titleLabel.text = title
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descriptionLabel.text = desc
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        self.isUserInteractionEnabled = false
        // Initialization code
    }

    func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
//        descriptionLabel.font = UIFont(name: "Rounded-Regular", size: 14)
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
