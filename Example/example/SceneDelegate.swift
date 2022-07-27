//
//  SceneDelegate.swift
//  example
//
//  Created by Benjamin Kramser on 19.01.22.
//

import UIKit
import Steuerbot

var framework: SteuerbotSDK?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func navigateBack() {
        let navigationController = window!.rootViewController as! UINavigationController
        navigationController.popToRootViewController(animated: false)
    }
    
    func openPaymentModal(url: URL) {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let items = (urlComponents?.queryItems)
        guard let submitId = items?.first(where: {$0.name == "submitId"})?.value,
              let offerId = items?.first(where: {$0.name == "offerId"})?.value,
              let botId = items?.first(where: {$0.name == "botId"})?.value,
              let purpose = items?.first(where: {$0.name == "purpose"})?.value,
              let iban = items?.first(where: {$0.name == "iban"})?.value,
              let refund = items?.first(where: {$0.name == "refund"})?.value
        else {
            let alert = UIAlertController(title: "Invalid URL", message: "The provided payment URL is missing a required query parameter", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        let paymentVC : PaymentViewController = window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        paymentVC.submitId = submitId
        paymentVC.offerId = offerId
        paymentVC.botId = botId
        paymentVC.purpose = purpose
        paymentVC.iban = iban
        paymentVC.refund = refund
        
        window?.rootViewController?.present(paymentVC, animated: true)
    }
    
    func handleURL(_ url: URL) {
        switch url.lastPathComponent {
        case "goback":
            navigateBack()
            break
        case "payment":
            openPaymentModal(url: url)
            break
        default:
            break
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleURL(url)
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

