//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 22/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var menuItems = [MenuItem]()
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.capitalized
        MenuController.shared.fetchMenuItems(categoryName: category) { (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
            }
        }
        print(menuItems)
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath) as! MenuTableViewCell
        let menuItem = menuItems[indexPath.row]
        cell.menuMealTitle?.text = menuItem.name
        cell.menuMealPrice?.text = String(format: "$%.2f", menuItem.price)
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                cell.menuImage?.image = image
            }
        }
//        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
//    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
//        let menuItem = menuItems[indexPath.row]
//        cell.textLabel?.text = menuItem.name
//        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
//        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
//            guard let image = image else {return}
//            DispatchQueue.main.async {
//                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
//                    return
//                }
//                cell.imageView?.image = image
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailViewController = segue.destination as! MenuItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuItemDetailViewController.menuItem = menuItems[index]
        }
    }
    
}

// Backup of working non-custom cell

//import UIKit
//
//class MenuTableViewController: UITableViewController {
//    var menuItems = [MenuItem]()
//    var category: String!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = category.capitalized
//        MenuController.shared.fetchMenuItems(categoryName: category) { (menuItems) in
//            if let menuItems = menuItems {
//                self.updateUI(with: menuItems)
//            }
//        }
//        print(menuItems)
//    }
//    
//    func updateUI(with menuItems: [MenuItem]) {
//        DispatchQueue.main.async {
//            self.menuItems = menuItems
//            self.tableView.reloadData()
//        }
//    }
//
//    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menuItems.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath)
//        configure(cell: cell, forItemAt: indexPath)
//        return cell
//    }
//
//    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
//        let menuItem = menuItems[indexPath.row]
//        cell.textLabel?.text = menuItem.name
//        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
//        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
//            guard let image = image else {return}
//            DispatchQueue.main.async {
//                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
//                    return
//                }
//                cell.imageView?.image = image
//            }
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MenuDetailSegue" {
//            let menuItemDetailViewController = segue.destination as! MenuItemDetailViewController
//            let index = tableView.indexPathForSelectedRow!.row
//            menuItemDetailViewController.menuItem = menuItems[index]
//        }
//    }
//
//}
