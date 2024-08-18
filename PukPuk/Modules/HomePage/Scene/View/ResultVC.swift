//
//  ResultVCViewController.swift
//  PukPuk
//
//  Created by Sena Kristiawan on 14/08/24.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet var causeLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var xReviewButton: UIButton!
    @IBOutlet var checkReviewButton: UIButton!
    
//    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cards: [UIView]!
    @IBOutlet var buttons: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for card in cards {
            card.layer.cornerRadius = 12
        }
        
        for button in buttons{
            button.layer.cornerRadius = 12
        }
        
//        imageView.layer.cornerRadius = imageView.layer.frame.size.width/2
//        imageView.layer.masksToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        
        
        
    }
    
    @IBAction func xAction(_ sender: Any) {
        
    }
    
    @IBAction func checkAction(_ sender: Any) {
    }
}
