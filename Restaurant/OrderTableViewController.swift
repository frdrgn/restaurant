//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 22/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

protocol AddToOrderDelegate {
    func added(menuItem: MenuItem)
}

class OrderTableViewController: UITableViewController, AddToOrderDelegate {
    var menuItems = [MenuItem]()
    var orderMinutes: Int?
    
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        let count = menuItems.count
        let indexPath = IndexPath(row: count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Order"
    }
    
    func updateBadgeNumber() {
        let badgeValue = menuItems.count > 0 ? "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            menuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
        }
    }
    
    func uploadOrder() {
        let menuIds = menuItems.map { $0.id }
        MenuController.shared.submitOrder(menuIds: menuIds) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    print("orderMinutes = \(self.orderMinutes!)")
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                }
            }
        }
    }

    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal = menuItems.reduce(0.0) { (result, menuItem) -> Double in
            return result + menuItem.price
            
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirmation Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in
            self.uploadOrder()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
            menuItems.removeAll()
            tableView.reloadData()
            updateBadgeNumber()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination as! OrderConfirmationViewController
            print("orderMinutes in prepare func: \(orderMinutes!)")
            orderConfirmationViewController.minutes = orderMinutes
        }
    }
}
