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
    private let temp: Double
    private let feels: Float
    private let pressure, clouds, humidity, visibility: Int
    let dt: Int
    let sunset, sunrise: Int?
    var temperatureString: String { return String(format: "%.1f", temp) + "°" }
    var feelString: String { return String(format: "%.1f", feels) + "°" }
    var pressureString: String { return "\(pressure) гПа" }
    var cloudsString: String { return "\(clouds)%" }
    var humidityString: String { return "\(humidity)%" }
    var visibilityString: String { return "\(humidity) км." }
    let weather: [Weather]
    enum CodingKeys: String, CodingKey {
        case feels = "feels_like"
        case dt, temp, weather, pressure, clouds, humidity, visibility
        case sunset, sunrise
    }
}

// MARK: - Daily
struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    var systemIconNameString: String {
        let icon = CityWeatherIcon(CityWeatherIcon: id)
        return icon.systemIconNameString
    }
    private let weatherDescription: String
    var newDescription: String {
        let description = weatherDescription.components(separatedBy: " ")
        return description[0]
    }
    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
    }
}

// MARK: - Temp
struct Temp: Codable {
    private let max, min: Double
    var temperatureStringMinMax: String {
        return String(format: "%.1f", min) + "°" + " / " + String(format: "%.1f", max) + "°"
    }
}
