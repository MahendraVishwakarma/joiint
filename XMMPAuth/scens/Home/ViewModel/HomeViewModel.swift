//
//  HomeViewModel.swift
//  XMMPAuth
//
//  Created by Mahendra Vishwakarma on 24/10/21.
//

import Foundation

class HomeViewModel{
    var cityListObj:CityListModel?
    weak var delegate: CityUpdateDelegate?
    
    func saveWeatherData() {
        let userDefaults = UserDefaults.standard
        if let saveObj = cityListObj {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(saveObj) {
                userDefaults.set(encoded, forKey: "weather")
                userDefaults.synchronize()
            }
            
        }
        
    }
    func fetchLocalStorage() {
        let userDefaults = UserDefaults.standard
        if let encoded = userDefaults.object(forKey: "weather") as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(CityListModel.self, from: encoded) {
               cityListObj = decoded
                delegate?.updateList(status: 2)
            } else {
                delegate?.updateList(status: 3)
            }
        }
        
    }
    func fetchCities() {
        let requestURL = Utils.cityURL
        
        WebServices.requestHttp(urlString: requestURL, method: .Get, param: nil, decode: { (json) -> CityListModel? in
            guard let response = json as? CityListModel else{
                return nil
            }
            return response
            
        }) { [weak self] (result) in
            
            switch result {
            case .success(let response) :
                if let data = response {
                    self?.cityListObj = data
                    self?.delegate?.updateList(status: 1)
                    
                }else {
                    self?.delegate?.updateList(status: 0)
                }
                break
            case .failure(let error) :
                print(error.localizedDescription)
                self?.delegate?.updateList(status: 0)
                break
            }
            
        }
    }
}


protocol CityUpdateDelegate:AnyObject {
    func updateList(status:Int)
}
