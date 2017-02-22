//
//  ConversionViewController.swift
//  WorldTrotter
//  Challenges Done
//  Created by Alex Louzao on 1/25/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit


class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsius()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelsius(){
        if let celsiusValue = celsiusValue{
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
 
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let number = numberFormatter.number(from: text){
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    // Generates a random color to assign to the background of the 
    // temperature tab. It will also change the color to a dark gray
    // once the time reaches 5 in the evening, and stay like that until 7 am

    
    override func viewWillAppear(_ animated: Bool){
        super.viewDidLoad()
        let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        print("Color \(red)")
        print("Color \(green)")
        print("Color \(blue)")
        let date = Date()
        print("Time of day hour: \(date)")
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        print("Time of day hour: \(hour)")
        if hour > 17 && hour < 7{
            self.view.backgroundColor = UIColor.darkGray
        } else {
            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        print("ConversionViewController loaded its view.")
        updateCelsius()
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 1
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // Sets the text field to allow user input and check so that only one 
    // decimal or comma can be entered depending on the region.
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)->Bool{
        let allowed =
            string.rangeOfCharacter(from: (NSCharacterSet(charactersIn: "0123456789.,-")) as CharacterSet)
        
        print("Current Text: \(textField.text)")
        print("Replacement text: \(string)")
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)

        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil
            || allowed == nil && string.characters.count >= 1){
            return false
        } else {
               return true
        }
   }
    
  

}
















