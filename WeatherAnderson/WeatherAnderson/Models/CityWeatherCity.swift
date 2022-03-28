//
//  CityWeatherData.swift
//  WeatherAnderson
//
//  Created by sleman on 27.03.22.
//

import Foundation

struct CityWeatherCity: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Int
    let coord: Coord
}

struct Coord: Codable {
    let lon, lat: Double
}


// MARK: - Main
struct Main: Decodable {
    let temp: Double
}


