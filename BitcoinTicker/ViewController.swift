//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
	let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
	
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
		currencyPicker.delegate = self
		currencyPicker.dataSource = self
		getData(url: baseURL + "AUD", row: 0 )
		
       
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return currencyArray.count
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return currencyArray[row]
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		finalURL = baseURL + currencyArray[row]
		getData(url: finalURL, row: row)
	}

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
	
	func getData(url: String, row : Int ) {
		
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the weather data")
                    let currencyJSON : JSON = JSON(response.result.value!)

					//print(currencyJSON)
                    self.updateWeatherData(json: currencyJSON, row: row)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

	
	
	
//
//    //MARK: - JSON Parsing
//    /***************************************************************/

	func updateWeatherData(json : JSON, row : Int) {
		
        if let tempResult = json["last"].double {
				print(tempResult)
				updateUI(result: Int(tempResult), row: row)
			
	        }
		
		
    }
	
	func updateUI(result: Int, row : Int) {
		bitcoinPriceLabel.text =  symbolArray[row] + String(result)
	}



}

