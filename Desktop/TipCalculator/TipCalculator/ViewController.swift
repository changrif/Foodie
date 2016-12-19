//
//  ViewController.swift
//  TipCalculator
//
//  Created by Chandler Griffin on 12/18/16.
//  Copyright © 2016 Chandler Griffin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var TipLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var TipSelector: UISegmentedControl!
    
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var MoneyField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let splitNum = roundf(splitSlider.value)
        
        let totalCheck = Double(MoneyField.text!) ?? 0
        
        let bill = totalCheck/Double(splitNum)
        
        let tipPercentages = [0.15, 0.2, 0.25]
        
        let tip = bill * tipPercentages[TipSelector.selectedSegmentIndex]
        let total  = bill + tip
        
        splitLabel.text = String(format: "%.f", splitNum)
        TipLabel.text = String(format: "$%.2f", tip)
        TotalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

