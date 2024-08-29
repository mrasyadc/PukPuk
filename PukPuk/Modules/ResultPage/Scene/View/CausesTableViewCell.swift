//
//  CausesTableViewCell.swift
//  App
//
//  Created by Jason Susanto on 22/08/24.
//

import UIKit

class CausesTableViewCell: UITableViewCell {

    @IBOutlet weak var causeName: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    static let identifier = "CausesTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CausesTableViewCell", bundle: nil)
    }
    
    public func configure(causeName: String, rank: String){
        self.causeName.text = causeName
        self.rankLabel.text = rank
        let tempCauseName = causeName.lowercased().replacingOccurrences(of: " ", with: "-")
        if let classificationResult = ClassificationResult(rawValue: causeName.lowercased().replacingOccurrences(of: " ", with: "_")) {
            self.iconImage.image = UIImage(named: classificationResult.rawValue)
        } else {
            self.iconImage.image = UIImage(systemName: "questionmark.circle")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        causeName.font = .systemFont(ofSize: 14)
        causeName.setContentHuggingPriority(.required, for: .vertical)
        causeName.setContentCompressionResistancePriority(.required, for: .vertical)
        
        rankLabel.textColor = UIColor(resource: .lightPurple)
        rankLabel.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
