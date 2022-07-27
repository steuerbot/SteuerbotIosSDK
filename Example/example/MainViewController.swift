//
//  SteuerbotViewController.swift
//  example
//
//  Created by Benjamin Kramser on 19.01.22.
//

import UIKit
import Steuerbot
import CryptoKit

class MainViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forenameOutlet.text = defaults.string(forKey: "forename")
        surenameOutlet.text = defaults.string(forKey: "surename")
        mailOutlet.text = defaults.string(forKey: "mail")
        apiOutlet.text = defaults.string(forKey: "api") ?? "https://api.staging.steuerbot.com"
        lightThemeOutlet.text = defaults.string(forKey: "lighttheme")
        darkThemeOutlet.text = defaults.string(forKey: "darktheme")
        inputChanged()
        languageButtonSetup()
    }
    
    @IBOutlet weak var startSteuerbotOutlet: UIButton!
    @IBOutlet weak var forenameOutlet: UITextField!
    @IBOutlet weak var surenameOutlet: UITextField!
    @IBOutlet weak var mailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var apiOutlet: UITextField!
    @IBOutlet weak var debugOutlet: UISwitch!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var lightThemeOutlet: UITextField!
    @IBOutlet weak var darkThemeOutlet: UITextField!
    
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
    
    @IBAction func apiAction(_ sender: Any) {
        defaults.set(apiOutlet.text, forKey: "api")
        inputChanged()
    }
    
    @IBAction func startSteuerbotActionButton(_ sender: Any) {
        openSteuerbotSDK()
    }
    
    @IBAction func lightThemeAction(_ sender: Any) {
        defaults.set(lightThemeOutlet.text, forKey: "lighttheme")
        inputChanged()
    }
    
    @IBAction func darkThemeAction(_ sender: Any) {
        defaults.set(darkThemeOutlet.text, forKey: "darktheme")
        inputChanged()
    }
    
    func languageButtonSetup() {
        
        languageButton.menu = UIMenu(children: [
            UIAction(title: "de", state: .on, handler: { _ in }),
            UIAction(title: "en", state: .off, handler: { _ in })
        ])
        
        languageButton.showsMenuAsPrimaryAction = true
        languageButton.changesSelectionAsPrimaryAction = true
    }
    
    func areInputsFilled() -> Bool {
        return forenameOutlet.text != "" &&
        surenameOutlet.text != "" &&
        mailOutlet.text != "" &&
        passwordOutlet.text != "" &&
        apiOutlet.text != ""
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
        
        guard let hash = getPwHash(pw: passwordOutlet.text!) else {
            let alert = UIAlertController(
                title: "Error generating hash",
                message: "An Error occured while generationg the password hash.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let user = User(
            email: mailOutlet.text!,
            forename: forenameOutlet.text!,
            surname: surenameOutlet.text!
        )
        
        framework = SteuerbotSDK(
            debug: debugOutlet.isOn,
            partnerId: "sdktest",
            partnerName: "Steuerbot",
            token: hash.lowercased(),
            user: user,
            paymentLink: "com.steuerbot.sdk.example://steuerbot.com/payment",
            backButtonLink: "com.steuerbot.sdk.example://steuerbot.com/goback",
            showCloseBackIcon: true,
            apiUrl: apiOutlet.text,
            language: Language(rawValue: languageButton.menu?.selectedElements.first?.title ?? "de"),
            lightTheme: lightThemeOutlet.text != "" ? lightThemeOutlet.text : nil,
            darkTheme: darkThemeOutlet.text != "" ? darkThemeOutlet.text : nil
        )
        
        let steuerbotController = UIViewController()
        steuerbotController.view = framework?.getView()
        self.navigationController?.pushViewController(steuerbotController, animated: false)
    }
}

