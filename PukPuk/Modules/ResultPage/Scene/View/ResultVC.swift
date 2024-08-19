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
    @IBOutlet var imageCause: UIImageView!
    @IBOutlet var cards: [UIView]!
    @IBOutlet var buttons: [UIButton]!
    
    var vm : ResultViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for card in cards {
            card.layer.cornerRadius = 12
        }
        
        for button in buttons{
            button.layer.cornerRadius = 12
        }
        
        vm.checkAndGetModelResult()
        causeLabel.text = vm.cause
        percentageLabel.text = vm.percentage
        
    }
    
    @IBAction func xAction(_ sender: Any) {
        
    }
    
    @IBAction func checkAction(_ sender: Any) {
    }
}
