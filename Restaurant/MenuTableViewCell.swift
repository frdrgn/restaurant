//
//  MenuTableViewCell.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 29/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuMealTitle: UILabel!
    @IBOutlet weak var menuMealPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.menuImage?.layer.cornerRadius = (self.menuImage?.frame.size.width)! / 2
        self.menuImage?.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
