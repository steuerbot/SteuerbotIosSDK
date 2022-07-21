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
    
    // TODO: Move
    func handleURL(_ url: URL) {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let items = (urlComponents?.queryItems)! as [NSURLQueryItem]
        
        if (url.lastPathComponent == "payment") {
            
            // TODO: Improve Init
            guard let submitId = items.first(where: {$0.name == "submitId"})?.value,
                  let offerId = items.first(where: {$0.name == "offerId"})?.value,
                  let botId = items.first(where: {$0.name == "botId"})?.value,
                  let purpose = items.first(where: {$0.name == "purpose"})?.value,
                  let iban = items.first(where: {$0.name == "iban"})?.value,
                  let refund = items.first(where: {$0.name == "refund"})?.value
            else {
                // TODO
                print("Provided URL isn't valid")
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
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleURL(url)
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

