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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forenameOutlet.text = defaults.string(forKey: "forename")
        surenameOutlet.text = defaults.string(forKey: "surename")
        mailOutlet.text = defaults.string(forKey: "mail")
        inputChanged()
    }
    
    @IBOutlet weak var startSteuerbotOutlet: UIButton!
    @IBOutlet weak var forenameOutlet: UITextField!
    @IBOutlet weak var surenameOutlet: UITextField!
    @IBOutlet weak var mailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBAction func forenameAction(_ sender: Any) {
        defaults.set(forenameOutlet.text, forKey: "forename")
        inputChanged()
    }
    
    @IBAction func surenameAction(_ sender: Any) {
        defaults.set(surenameOutlet.text, forKey: "surename")
        inputChanged()
    }
    
    @IBAction func mailAction(_ sender: Any) {
        defaults.set(mailOutlet.text, forKey: "mail")
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
    
    func getPwHash(pw: String) -> String? {
        guard let data = pw.data(using: .utf8) else { return nil }
        let digest = SHA512.hash(data: data)
        return digest.hexStr
    }
    
    func openSteuerbotSDK() {
        if (!areInputsFilled()) {
            return
        }
        
        let user = User(email: mailOutlet.text!, forename: forenameOutlet.text!, surname: surenameOutlet.text!)
        let hash = getPwHash(pw: passwordOutlet.text!)?.lowercased()
        
        if (hash == nil) {
            let alert = UIAlertController(title: "Error generating hash", message: "An Error occured while generationg the password hash.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        framework = SteuerbotSDK(debug: true, partnerId: "sdktest", partnerName: "Steuerbot", token: hash!, user: user, paymentLink: "com.steuerbot.sdk.example://steuerbot.com/payment", showCloseBackIcon: true, apiUrl: "https://api.test.steuerbot.com")
        
        self.view = framework?.getView()
    }
}
