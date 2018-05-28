//
//  OrderTableViewCell.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 28/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var mealPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.mealImage.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        self.mealImage?.layer.cornerRadius = (self.mealImage?.frame.size.width)! / 2
        self.mealImage?.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
