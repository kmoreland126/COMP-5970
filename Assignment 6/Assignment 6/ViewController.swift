//
//  ViewController.swift
//  Assignment 6
//
//  Created by Kate Moreland on 6/29/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var poundsSwitch: UISwitch!
    @IBOutlet weak var eurosSwitch: UISwitch!
    @IBOutlet weak var pesoSwitch: UISwitch!
    @IBOutlet weak var yenSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
          guard let inputText = usdTextField.text, let usdAmount = Int(inputText) else {
              errorLabel.text = "Please enter a valid integer"
              return
          }

          performSegue(withIdentifier: "showResults", sender: usdAmount)
      }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            guard let destinationVC = segue.destination as? ResultViewController,
                  let usdString = usdTextField.text,
                  let usdAmount = Int(usdString) else {
                errorLabel.text = "Please enter a valid integer amount."
                return
            }
            
            var selectedCurrencies = [String]()
            if poundsSwitch.isOn { selectedCurrencies.append("GBP") }
            if eurosSwitch.isOn { selectedCurrencies.append("EUR") }
            if pesoSwitch.isOn { selectedCurrencies.append("MEX") }
            if yenSwitch.isOn { selectedCurrencies.append("JAP") }
            
            destinationVC.usdAmount = usdAmount
            destinationVC.selectedCurrencies = selectedCurrencies
        }
    }
}

