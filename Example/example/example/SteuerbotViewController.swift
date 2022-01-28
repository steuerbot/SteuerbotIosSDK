//
//  SteuerbotViewController.swift
//  example
//
//  Created by Benjamin Kramser on 19.01.22.
//

import UIKit
import Steuerbot

var framework: SteuerbotSDK?

let user = User(email: "sdk01@byom.de", forename: "Max", surname: "Power")

class SteuerbotViewController: UIViewController {

    override func viewDidLoad() {
        framework = SteuerbotSDK(partnerId: "vivid", token: "testing", user: user)
        self.view = framework?.getView()
        super.viewDidLoad()
    }
}

