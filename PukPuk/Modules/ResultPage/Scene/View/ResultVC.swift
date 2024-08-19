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
    
    var vm : ResultViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for card in cards {
            card.layer.cornerRadius = 12
        }
        
        for button in buttons{
            button.layer.cornerRadius = 12
        }
        
//        imageCause.layer.cornerRadius = imageCause.layer.frame.size.width/2
//        imageCause.layer.masksToBounds = true
//        imageCause.contentMode = .scaleAspectFill
        
//        causeLabel.text = vm.cause.isEmpty ? "bjir" : vm.cause
//        if let vm = vm {
//            causeLabel.text = vm.cause.lowercased()
//        } else {
//            causeLabel.text = "Default Cause"  // Fallback if vm is nil
//        }
        
        causeLabel.text = vm.cause

//        percentageLabel.text = vm.percentage
        
    }
    
    @IBAction func xAction(_ sender: Any) {
        
    }
    
    @IBAction func checkAction(_ sender: Any) {
    }
}
