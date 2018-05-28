//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 24/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your waiting time is approximately \(minutes!) minutes."
    }


    @IBAction func dismissButtonTapped(_ sender: Any) {

    }
    
}
