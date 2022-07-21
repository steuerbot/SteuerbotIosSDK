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
    
    var price = 1000
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
        setLabels()
        super.viewDidLoad()
    }
    
    func setLabels() {
        let refundInt = Int(refund ?? "")
        priceLabel.text = "\(price/100) €"
        purposeLabel.text = "\(purpose ?? "-")"
        ibanLabel.text = "\(iban ?? "-")"
        refundLabel.text = "\(refundInt != nil ? String(refundInt!/100) : "-") €"
        submitIdLabel.text = "SubmitId: \(submitId ?? "-")"
        offerIdLabel.text = "OfferId: \(offerId ?? "-")"
        botIdLabel.text = "BotId: \(botId ?? "-")"
    }
    
    @IBAction func payActionButton(_ sender: Any) {
        if ( submitId == nil || offerId == nil || botId == nil) {
            // TODO: Handle
            return
        }
        
        framework?.triggerAction(action: .paymentSuccess(price: price, submitId: submitId!, offerId: offerId!, botId: botId!))
        
        self.dismiss(animated: true)
    }
}


