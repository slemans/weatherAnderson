//
//  CityWeatherData.swift
//  WeatherAnderson
//
//  Created by sleman on 27.03.22.
//

import Foundation

struct CityWeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
    
//    let daily: [Daily]
}

// MARK: - Main

struct Main: Decodable {
    let temp: Double
}

// MARK: - Sys

struct Sys: Decodable {
    let country: String
}

// MARK: - Weather



struct Hourly: Decodable {
    let weather: [Weather]
    let temp: Double
    let dt: Int

    enum CodingKeys: String, CodingKey {
        case weather, temp, dt
    }
}

struct Daily: Decodable {
    let temp: Temp
    let dt: Int
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case temp, dt, weather
    }
}
struct Weather: Decodable {
    let id: Int
}

struct Temp: Codable {
    let day: Double
}
