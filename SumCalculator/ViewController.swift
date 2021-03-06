//
//  ViewController.swift
//  MumCalculator
//
//  Created by Jasmine Lu on 03/08/2016.
//  Copyright © 2016 jasmienlu. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView_1: UITableView!
    @IBOutlet weak var tableView_2: UITableView!
    
    @IBOutlet weak var total1: UILabel!
    @IBOutlet weak var total2: UILabel!
    @IBOutlet weak var first: UIButton!
    @IBOutlet weak var second: UIButton!
    @IBOutlet weak var calcDisplay: UITextField!
    var firstValue = true
    var decimal = 0
    var firstArray = [Float]()
    var secondArray = [Float]()
    var firstCalc = true
    
    var firstTotal: Float = 0
    var secondTotal: Float = 0
    
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calcDisplay.text = ""
        
        self.tableView_1.delegate = self
        self.tableView_1.dataSource = self
        self.tableView_2.delegate = self
        self.tableView_2.dataSource = self
        
        first.backgroundColor = UIColor(red: 71/255, green: 178/255, blue: 245/255, alpha: 1.0)
        second.backgroundColor = UIColor.white
        
        total1.text = String(format:"%.2f", firstTotal)
        total2.text = String(format:"%.2f", secondTotal)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows1 = firstArray.count
        let rows2 = secondArray.count
        return (tableView == self.tableView_1) ? rows1 : rows2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView_1 {
            let cell: classTableView_1 = tableView.dequeueReusableCell(withIdentifier: "cellTableView_1") as! classTableView_1
            cell.label_text.text = "\(indexPath.row + 1):     \(String(format:"%.2f", firstArray[indexPath.row]))"
            return cell
        } else {
            let cell: classTableView_2 = tableView.dequeueReusableCell(withIdentifier: "cellTableView_2") as! classTableView_2
            cell.label_text.text = "\(indexPath.row + 1):     \(String(format:"%.2f", secondArray[indexPath.row]))"
            return cell
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearCalculations(_ sender: AnyObject) {
        calcDisplay.text = ""
        firstValue = true
        decimal = 0
    }
    
    @IBAction func clear1(_ sender: AnyObject) {
        
        firstArray = [Float]()
        firstTotal = 0
        
        total1.text = String(format:"%.2f", firstTotal)
        
        tableView_1.reloadData()
    }
    
    @IBAction func clear2(_ sender: AnyObject) {
        
        secondArray = [Float]()
        secondTotal = 0
        
        total2.text = String(format:"%.2f", secondTotal)
        
        tableView_2.reloadData()
    }
    
    @IBAction func pressZero(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "0"
        } else {
            calcDisplay.text = calcDisplay.text! + "0"
        }
    }
    
    @IBAction func pressEquals(_ sender: AnyObject) {
    }
    
    @IBAction func pressPlus(_ sender: AnyObject) {
        if calcDisplay.text == "" {
            
        } else {
            if firstCalc {
                firstArray.append(Float(calcDisplay.text!)!)
                firstTotal += Float(calcDisplay.text!)!
                total1.text = String(format:"%.2f", firstTotal)
                calcDisplay.text = ""
                tableView_1.reloadData()
            } else {
                if (secondArray.count + 1) > firstArray.count {
                    let alertController = UIAlertController(title: "Error", message: "Too Many", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default) {(action) in
                        self.resignFirstResponder()
                    }
                    
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if Float(calcDisplay.text!)! == firstArray[secondArray.count] {
                        secondArray.append(Float(calcDisplay.text!)!)
                        secondTotal += Float(calcDisplay.text!)!
                        total2.text = String(format:"%.2f", secondTotal)
                        calcDisplay.text = ""
                        tableView_2.reloadData()
                    } else {
                        let alertView = UIAlertController(title: "Did not Match", message: "Check Value", preferredStyle: .alert)
                        
                        let checkOption = UIAlertAction(title: "Check", style: .default) {(action) in
                            
                        }
                        let continueOption = UIAlertAction(title: "Continue", style: .default) {(action) in
                            self.secondArray.append(Float(self.calcDisplay.text!)!)
                            self.secondTotal += Float(self.calcDisplay.text!)!
                            self.total2.text = String(format:"%.2f", self.secondTotal)
                            self.calcDisplay.text = ""
                            self.tableView_2.reloadData()
                        }
                        
                        alertView.addAction(checkOption)
                        alertView.addAction(continueOption)
                        
                        self.present(alertView, animated: true, completion: nil)
                    }
                }
                
            }
            decimal = 0

        }
    }

    @IBAction func clearAll(_ sender: AnyObject) {
        //TODO clear both arrays
        //alert view to confirm
        first.backgroundColor = UIColor(red: 71/255, green: 178/255, blue: 245/255, alpha: 1.0)
        second.backgroundColor = UIColor.white
        firstValue = true
        decimal = 0
        firstArray = [Float]()
        secondArray = [Float]()
        firstCalc = true
        
        firstTotal = 0
        secondTotal = 0
        
        total1.text = String(format:"%.2f", firstTotal)
        total2.text = String(format:"%.2f", secondTotal)
        
        calcDisplay.text = ""
        tableView_1.reloadData()
        tableView_2.reloadData()
    }
    
    @IBAction func firstTime(_ sender: AnyObject) {
        //clear first array
        first.backgroundColor = UIColor(red: 71/255, green: 178/255, blue: 245/255, alpha: 1.0)
        second.backgroundColor = UIColor.white
        firstCalc = true
    }
    
    @IBAction func secondTime(_ sender: AnyObject) {
        //clear second array
        second.backgroundColor = UIColor(red: 71/255, green: 178/255, blue: 245/255, alpha: 1.0)
        first.backgroundColor = UIColor.white
        firstCalc = false
    }
    
    @IBAction func pressBack(_ sender: AnyObject) {
        if calcDisplay.text == "" {
            
        } else {
            let str: String = calcDisplay.text!
            let truncated = String(str.dropLast())
            calcDisplay.text = truncated
        }
    }
    
    @IBAction func pressOne(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "1"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "1"
        }
    }
    
    @IBAction func pressTwo(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "2"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "2"
        }
    }
    
    @IBAction func pressThree(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "3"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "3"
        }
    }
    
    @IBAction func pressFour(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "4"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "4"
        }
    }
    
    @IBAction func pressFive(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "5"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "5"
        }
    }
    
    @IBAction func pressSix(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "6"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "6"
        }
    }
    
    @IBAction func pressSeven(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "7"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "7"
        }
    }
    
    @IBAction func pressEight(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "8"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "8"
        }
    }
    
    @IBAction func pressNine(_ sender: AnyObject) {
        if firstValue {
            calcDisplay.text = "9"
            firstValue = false
        } else {
            calcDisplay.text = calcDisplay.text! + "9"
        }
    }
    
    @IBAction func pressDot(_ sender: AnyObject) {
        if (decimal == 0) {
            calcDisplay.text = calcDisplay.text! + "."
            decimal = 1
            firstValue = false
        }
        
    }
}

