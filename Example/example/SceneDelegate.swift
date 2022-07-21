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
            guard let price = items.first(where: {$0.name == "price"})?.value,
                  let submitId = items.first(where: {$0.name == "submitId"})?.value,
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
            paymentVC.price = price
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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let url = URLContexts.first?.url else { return }
        handleURL(url)
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

