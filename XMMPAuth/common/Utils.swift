//
//  Utils.swift
//  XMMPAuth
//
//  Created by Mahendra Vishwakarma on 24/10/21.
//

import Foundation
class Utils {
    static let cityURL = "http://api.openweathermap.org/data/2.5/find?lat=15.3173&lon=75.7139&cnt=50&appid=ca648534ff7ed2d9b633adb2a76fc56e"
    static let weatherDetails = ""
}

//Result type
public enum Result<T, U> where U:Error {
    case success(T)
    case failure(U)
}

// custom error
public enum APIError:Error {
     case failedRequest(String?)
}
// hTTPS methods type
public enum HttpsMethod {
    case Post
    case Get
    case Put
    case Delate
    
    var localization:String{
        switch self {
        case .Post: return "POST"
        case .Get: return "GET"
        case .Put: return "PUT"
        case .Delate: return "Delete"
            
        }
        
    }
}
