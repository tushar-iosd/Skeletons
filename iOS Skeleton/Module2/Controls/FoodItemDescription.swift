//
//  FoodItemDescription.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 21/06/21.
//

import UIKit

class FoodItemDescription: UIViewController {

    @IBOutlet weak var selectedFoodImageView: UIImageView!
    @IBOutlet weak var selectedFoodLabel: UILabel!
    var labelText: String = ""
    var imageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFoodImageView.image = UIImage(named: imageName)
        selectedFoodLabel.text = labelText
        // Do any additional setup after loading the view.
    }
}
