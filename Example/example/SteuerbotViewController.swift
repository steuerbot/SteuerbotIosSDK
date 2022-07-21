//
//  SteuerbotViewController.swift
//  example
//
//  Created by Benjamin Kramser on 19.01.22.
//

import UIKit
import Steuerbot
import CryptoKit

class SteuerbotViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputChanged()
    }
    
    @IBOutlet weak var startSteuerbotOutlet: UIButton!
    @IBOutlet weak var forenameOutlet: UITextField!
    @IBOutlet weak var surenameOutlet: UITextField!
    @IBOutlet weak var mailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBAction func forenameAction(_ sender: Any) {
        inputChanged()
    }
    
    @IBAction func surenameAction(_ sender: Any) {
        inputChanged()
    }
    
    @IBAction func mailAction(_ sender: Any) {
        inputChanged()
    }
    
    @IBAction func passwordAction(_ sender: Any) {
        inputChanged()
    }
    
    @IBAction func startSteuerbotActionButton(_ sender: Any) {
        openSteuerbotSDK()
    }
    
    func areInputsFilled() -> Bool {
        return forenameOutlet.text != "" &&
        surenameOutlet.text != "" &&
        mailOutlet.text != "" &&
        passwordOutlet.text != ""
    }
    
    func inputChanged() {
        startSteuerbotOutlet.isEnabled = areInputsFilled()
    }
    
    func getPwHash(pw: String) -> String {
        // TODO: Handle
        guard let data = pw.data(using: .utf8) else { return "" }
        let digest = SHA512.hash(data: data)
        return digest.hexStr
    }
    
    func openSteuerbotSDK() {
        if (!areInputsFilled()) {
            return
        }
        
        let user = User(email: mailOutlet.text!, forename: forenameOutlet.text!, surname: surenameOutlet.text!)
        framework = SteuerbotSDK(debug: true, partnerId: "sdktest", partnerName: "Steuerbot", token: getPwHash(pw: passwordOutlet.text!).lowercased(), user: user, paymentLink: "com.steuerbot.sdk.example://steuerbot.com/payment", showCloseBackIcon: true, apiUrl: "https://api.test.steuerbot.com")
        
        self.view = framework?.getView()
        
        //        let controller = UIViewController()
        //        controller.view = framework?.getView()
        //        controller.modalPresentationStyle = .overFullScreen
        //        self.present(controller, animated: true, completion: nil)
    }
}

