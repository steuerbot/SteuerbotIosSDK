//
//  ViewController.swift
//  example
//
//  Created by Benjamin Kramser on 19.01.22.
//

import UIKit
import Steuerbot

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func triggerAction(_ sender: Any) {
        framework?.triggerAction(action: .support)
    }
    
    @IBAction func startSteuerbot(_ sender: Any) {
        let controller = UIViewController()
        controller.view = framework?.getView()
        self.present(controller, animated: true, completion: nil)
    }
}

