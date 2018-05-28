//
//  SettingsViewController.swift
//  Restaurant
//
//  Created by Mikk Noorkõiv on 23/05/2018.
//  Copyright © 2018 Mikk Noorkõiv. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var ipAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newSettings = Settings.loadSettings() {
            Settings.shared = newSettings
        }
        ipAddressTextField.text = Settings.shared.ipAddress
        
        self.ipAddressTextField.delegate = self
        self.ipAddressTextField.returnKeyType = .go
    }
    
    func updateIp() {
        Settings.shared.ipAddress = ipAddressTextField.text ?? ""
        Settings.saveSettings(settings: Settings.shared.self)
        MenuController.shared.updateBaseURL(ipAddress: Settings.shared.ipAddress)
    }

    @IBAction func updateIpAddressButtonTapped(_ sender: Any) {
        updateIp()
        // Done in unwindswgue
//        CategoryTableViewController().fetchCategories()
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ipAddressTextField {
            textField.resignFirstResponder()
            print("Keyboard return pressed")
            updateIp()
            performSegue(withIdentifier: "DismissSettings", sender: nil)
            return false
        }
        return true
    }
}
