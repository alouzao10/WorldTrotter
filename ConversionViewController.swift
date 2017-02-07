//
//  ConversionViewController.swift
//  WorldTrotter
//
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
    // SEE WB FOR NOTES
    //    use viewDidAppear to change the color of the background
    //    make the background color different on each launch
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)->Bool{
        /*for chr in  string{
            if(!(chr >= 'a' && chr <= 'z') && !(chr >= 'a' && char <= 'z'))
        }*/
        
        //let numSet = NSCharacterSet.decimalDigits
        //let charSet = NSCharacterSet(charactersIn: string)
        //return numSet.isSuperset(of: charSet as CharacterSet)
        
        let allowed =
            string.rangeOfCharacter(from: (NSCharacterSet(charactersIn: "0123456789.,-")) as CharacterSet)
        
        print("Current Text: \(textField.text)")
        print("Replacement text: \(string)")
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        /*if string.rangeOfCharacter(from: NSCharacterSet.letters) != nil{
           return false
        }*/
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil
            || allowed == nil && string.characters.count >= 1){
            return false
            //return numSet.isSuperset(of: charSet as CharacterSet)
        } else {
               return true
               //return numSet.isSuperset(of: charSet as CharacterSet)
        }
   }
    
  

}
















