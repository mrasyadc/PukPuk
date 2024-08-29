//
//  FeedbackTableViewCell.swift
//  App
//
//  Created by Jason Susanto on 29/08/24.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell {

    static let identifier = "FeedbackTableViewCell"

    static func nib() -> UINib {
      return UINib(nibName: "FeedbackTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var feedBackLabel: UILabel!
    @IBOutlet weak var feedbackIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = UIColor(resource: .midPurple)
        } else {
            contentView.backgroundColor = .white
        }
    }
    
    public func configure(label: String) {
        feedBackLabel.text = label
        feedbackIcon.image = UIImage(named: label.lowercased().replacingOccurrences(of: " ", with: "_"))
    }
    
    func setupUI(){
        feedBackLabel.font = feedBackLabel.font.withSize(12)
        contentView.backgroundColor = .white
        
        // Add purple border
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor(resource: .midPurple).cgColor
        
        // Round corners
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        
        self.clipsToBounds = true
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 8
        contentView.frame = CGRect(
            x: 0,
            y: padding,
            width: self.frame.width,
            height: self.frame.height - 1 * padding
        )
    }
    
}
