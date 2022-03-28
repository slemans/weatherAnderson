//
//  CityWeatherCoordinate.swift
//  WeatherAnderson
//
//  Created by sleman on 28.03.22.
//

import Foundation

struct CityWeatherCoordinate: Decodable {
    let lat, lon: Double
    let hourly: [Current]
    let timezone: String
    let daily: [Daily]
    let current: Current
}

// MARK: - Current
struct Current: Decodable {
    let temp: Double
    let weather: [Weather]
    let dt: Int
}

// MARK: - Daily
struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let weatherDescription: String
        enum CodingKeys: String, CodingKey {
            case id
            case weatherDescription = "description"
        }
}

// MARK: - Temp
struct Temp: Codable {
    let max, min: Double
}
