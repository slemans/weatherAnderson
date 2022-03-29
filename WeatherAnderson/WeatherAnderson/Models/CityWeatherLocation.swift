//
//  CityWeatherLocation.swift
//  WeatherAnderson
//
//  Created by sleman on 29.03.22.
//

import Foundation

struct CityWeatherLocation {
    private let temperature: Double
    let hourly: [Current]
    let daily: [Daily]
    let timezone: String
    let lat, lon: Double
    let current: Current
    let dt: Int // Время расчета данных
    var temperatureString: String {
        return String(format: "%.1f", temperature) + "°"
    }
    
    init?(weatherLocation weather: CityWeatherCoordinate) {
        hourly = weather.hourly
        daily = weather.daily
        timezone = weather.timezone
        lat = weather.lat
        lon = weather.lon
        current = weather.current
        temperature = weather.current.temp
        dt = weather.current.dt
    }
}


