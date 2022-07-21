//
//  PaymentViewController.swift
//  example
//
//  Created by Benjamin Kramser on 20.07.22.
//

import Foundation
import UIKit
import Steuerbot

class PaymentViewController: UIViewController {
    
    var price: String?
    var purpose: String?
    var iban: String?
    var refund: String?
    
    var submitId: String?
    var offerId: String?
    var botId: String?
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var ibanLabel: UILabel!
    @IBOutlet weak var refundLabel: UILabel!
    @IBOutlet weak var submitIdLabel: UILabel!
    @IBOutlet weak var offerIdLabel: UILabel!
    @IBOutlet weak var botIdLabel: UILabel!
    
    override func viewDidLoad() {
        priceLabel.text = "Price: \(price ?? "-")€"
        purposeLabel.text = "Purpose: \(purpose ?? "-")"
        ibanLabel.text = "IBAN: \(iban ?? "-")"
        refundLabel.text = "Refund: \(refund ?? "-")"
        submitIdLabel.text = "SubmitId: \(submitId ?? "-")"
        offerIdLabel.text = "OfferId: \(offerId ?? "-")"
        botIdLabel.text = "BotId: \(botId ?? "-")"
        super.viewDidLoad()
    }
    
    @IBAction func payActionButton(_ sender: Any) {
        if (price == nil || submitId == nil || offerId == nil || botId == nil) {
            // TODO: Handle
            return
        }
        
        framework?.triggerAction(action: .paymentSuccess(price: Int(price!) ?? 0, submitId: submitId!, offerId: offerId!, botId: botId!))
        
        self.dismiss(animated: true)
    }
}


