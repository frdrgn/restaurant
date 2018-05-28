//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 22/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        fetchCategories()
    }
    
    func fetchCategories() {
        MenuController.shared.fetchCategories() { (categories) in
            if let categories = categories {
                self.updatUI(with: categories)
            }
        }
    }
    
    func updatUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            print(self.categories)
            self.tableView.reloadData()
        }
        print("UI updated")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
    }
    
    @IBAction func unwindToCategoryViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissSettings" {
            fetchCategories()
            
        }
    }

}
