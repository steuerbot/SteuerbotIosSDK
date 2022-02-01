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
        framework?.triggerAction(action: .paymentSuccess(price: 999, submitId: "98765", offerId: "61f29833a137d993740cc610", botId: "237f6193-f4e9-4258-b0f5-1f428e63013a"))
    }
    
    @IBAction func startSteuerbot(_ sender: Any) {
        let controller = UIViewController()
        controller.view = framework?.getView()
        self.present(controller, animated: true, completion: nil)
    }
}

