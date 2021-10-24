//
//  CityDetailViewController.swift
//  XMMPAuth
//
//  Created by Mahendra Vishwakarma on 24/10/21.
//

import UIKit

class CityDetailViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    var viewModel:CityDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
    }
    
    private func setData() {
        
        cityName.text = "City: " + (viewModel?.cityDetails?.name ?? "")
        coordinateLabel.text = "Lat & Long: \(viewModel?.cityDetails?.coord?.lat ?? 0)   \(viewModel?.cityDetails?.coord?.lon ?? 0)"
        tempLabel.text =  "Temp:  \(viewModel?.cityDetails?.main?.temp ?? 0)"
        humidityLabel.text = "Humidity: \(viewModel?.cityDetails?.main?.humidity ?? 0)"
    }

}
