//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 22/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var menuItem: MenuItem!
    var delegate: AddToOrderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()
        
    }
    
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = (String(format: "$%.2f", menuItem.price))
        descriptionLabel.text = menuItem.description
        addToOrderButton.layer.cornerRadius = 5.0
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func setupDelegate() {
        if let navController = tabBarController?.viewControllers?[1] as? UINavigationController, let orderTableViewController = navController.viewControllers.first as? OrderTableViewController {
            delegate = orderTableViewController
        }
    }

    @IBAction func addToOrderButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(menuItem: menuItem)
    }
}
