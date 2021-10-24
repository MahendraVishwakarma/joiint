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
