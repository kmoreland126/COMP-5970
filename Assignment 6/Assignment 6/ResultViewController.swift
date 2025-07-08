//
//  ResultViewController.swift
//  Assignment 6
//
//  Created by Kate Moreland on 6/29/25.
//

import UIKit

class CurrencyConverter {
    static func convert(usd: Int, to currency: String) -> Double {
        let rates: [String: Double] = [
            "GBP": 0.73,
            "EUR": 0.85,
            "MEX": 18.82,
            "JAP": 144.88
        ]
        
        if let rate = rates[currency] {
            return Double(usd) * rate
        } else {
            return 0.0
        }
    }
}

class ResultViewController: UIViewController {
    
    var usdAmount: Int = 0
    var selectedCurrencies: [String] = []
    
    @IBOutlet weak var poundsLabel: UILabel!
    @IBOutlet weak var eurosLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        poundsLabel.text = ""
        eurosLabel.text = ""
        pesoLabel.text = ""
        yenLabel.text = ""
        
        for currency in selectedCurrencies {
            let converted = CurrencyConverter.convert(usd: usdAmount, to: currency)
            let display = String(format: "%.2f", converted)
            
            switch currency {
                case "GBP": poundsLabel.text = "GBP: £\(display)"
                case "EUR": eurosLabel.text = "EUR: €\(display)"
                case "MEX": pesoLabel.text = "MEX: MX$\(display)"
                case "JAP": yenLabel.text = "JAP: ¥\(display)"
                default: break
            }
        }
    }
}
