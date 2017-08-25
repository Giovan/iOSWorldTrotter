//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Giovanni Delgado on 8/24/17.
//  Copyright © 2017 elesoft. All rights reserved.
//
import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    //MARK - IBOutlet
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    let inputMaxLimit = 6
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        updateCelsiusLabel()
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        //Get the hour completly Hour - Minutes - Seconds - Miliseconds
        //timeFormatter.dateFormat = "HH:mm:ss.S"
        timeFormatter.dateFormat = "HH"
        
        guard
            let actualTimeHour = Int(timeFormatter.string(from: date as Date))
        else{
            print("Error al obetener la hora")
            return
        }
        
        print("Actual Hour: \(actualTimeHour)")
        if actualTimeHour >= 19 {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(1.0)
        } else {
            self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    //MARK - Functions
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        return string == filtered
        
        /*let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }*/
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
