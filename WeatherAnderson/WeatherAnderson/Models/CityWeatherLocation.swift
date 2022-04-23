//
//  CityWeatherLocation.swift
//  WeatherAnderson
//
//  Created by sleman on 29.03.22.
//

import Foundation

struct CityWeatherLocation: Codable {
    let temperature: String
    private let timezone: String
    let hourly: [Current]
    let daily: [Daily]
    var nameCity: String {
        let myStringArr = timezone.components(separatedBy: "/")
        return myStringArr[1]
    }
    let lat, lon: Double
    let current: Current
    let dt: Int // Время расчета данных
    
    init?(weatherLocation weather: CityWeatherCoordinate) {
        hourly = weather.hourly
        daily = weather.daily
        timezone = weather.timezone
        lat = weather.lat
        lon = weather.lon
        current = weather.current
        temperature = weather.current.temperatureString
        dt = weather.current.dt
    }
}


