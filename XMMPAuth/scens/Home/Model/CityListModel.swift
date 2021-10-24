//
//  CityListModel.swift
//  XMMPAuth
//
//  Created by Mahendra Vishwakarma on 24/10/21.
//

import Foundation


// MARK: - CityListModel
struct CityListModel: Codable {
    let message, cod: String?
    let count: Int?
    let list: [CityList]?
}

// MARK: - List
struct CityList: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let main: MainClass?
    let dt: Int?
    let wind: Wind?
    let sys: Sys?
    let rain: Rain?
    let snow: String?
    let clouds: Clouds?
    let weather: [Weather]?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure, humidity
        case seaLevel
        case grndLevel
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String?
}


// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}
