//
//  RootTableViewController.swift
//  Example
//
//  Created by Remi Robert on 18/03/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import DeLogger

class RootTableViewController: UITableViewController {

    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            DeLogger.shared.enable()
        } else {
            DeLogger.shared.disable()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DeLogger test app"
    }
}
