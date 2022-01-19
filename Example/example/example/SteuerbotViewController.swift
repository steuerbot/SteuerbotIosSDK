//
//  SteuerbotViewController.swift
//  example
//
//  Created by Benjamin Kramser on 19.01.22.
//

import UIKit
import Steuerbot

class SteuerbotViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let framework = SteuerbotSDK()
        self.view = framework.getView()
    }
}

