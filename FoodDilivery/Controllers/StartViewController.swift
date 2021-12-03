//
//  StartViewController.swift
//  FoodDilivery
//
//  Created by Преподаватель on 03.12.2021.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtTtleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var state = 0
    let imagesArray: [UIImage?] = [UIImage(named: "Onboarding 4"), UIImage(named: "Onboarding 5"), UIImage(named: "Onboarding 6")]
    let titlesArray: [String] = ["Fresh Vegetables", "Easy Shopping", "Fast Delivery"]
    let subTitlessArray: [String] = ["Vegetables that are directly picked by farmersand guaranteed quality and freshness", "Grab your items only need to order from click pay and wait for the courier to arrive", "Courier will send the groceries you buy in just 1 day, very fast like a flash!"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func button(_ sender: Any) {
        state += 1
        
        if state < 3{
            image.image = imagesArray[state]
            titleLabel.text = titlesArray[state]
            subtTtleLabel.text = subTitlessArray[state]
            pageControl.currentPage = state
        }else{
            
        }
    }
    
}
