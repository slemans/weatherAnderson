//
//  CityWeather.swift
//  WeatherAnderson
//
//  Created by sleman on 27.03.22.
//

import Foundation

struct CityWeather {
    let cityName: String
    private let temperature: Double
    let dt: Int // Время расчета данных
    let lon, lat: Double
    var temperatureString: String {
        return String(format: "%.1f", temperature) + "°"
    }
    private let id: Int
    let weatherDescription: String
    var systemIconNameString: String {
        let icon = CityWeatherIcon(CityWeatherIcon: id)
        return icon.systemIconNameString
    }

    init?(CityWeatherData weather: CityWeatherCity) { // init? если не загрузит вернет nil
        cityName = weather.name
        temperature = weather.main.temp
        id = weather.weather.first!.id
        dt = weather.dt
        lon = weather.coord.lon
        lat = weather.coord.lat
        weatherDescription = weather.weather.first!.newDescription
    }
    
}
