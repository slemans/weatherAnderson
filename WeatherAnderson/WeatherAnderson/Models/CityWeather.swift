//
//  CityWeather.swift
//  WeatherAnderson
//
//  Created by sleman on 27.03.22.
//

import Foundation

struct CityWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }

    let country: String
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200 ... 232: return "cloud.bolt.rain.fill"
        case 300 ... 321: return "cloud.sleet.fill"
        case 500 ... 504: return "cloud.sun.rain.fill"
        case 511: return "snow"
        case 520 ... 531: return "cloud.heavyrain.fill"
        case 600 ... 622: return "snow"
        case 701 ... 781: return "smoke.fill"
        case 800: return "sun.max.fill"
        case 801 ... 804: return "cloud.fill"
        default:
            return "icloud.slash"
        }
    }

    init?(CityWeatherData: CityWeatherData) { // init? если не загрузит вернет nil
        cityName = CityWeatherData.name
        temperature = CityWeatherData.main.temp
        conditionCode = CityWeatherData.weather.first!.id
        country = CityWeatherData.sys.country
    }
}
