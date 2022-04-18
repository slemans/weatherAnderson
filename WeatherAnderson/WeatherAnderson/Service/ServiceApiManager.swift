//
//  ServiceApiManager.swift
//  WeatherAnderson
//
//  Created by sleman on 27.03.22.
//
import CoreLocation
import Foundation
import SwiftyJSON

class ServiceApiManager {
    static let shared = ServiceApiManager()
    private init() { }

    let apiKey = "7c869b6df2587f132c69a4700c43631f"

    enum TypeModel {
        case CityWeatherCity
        case CityWeatherLocation
    }

    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }

    private func fetchCityWeather(forRequestType: RequestType) -> URL? {
        var urlString = ""
        switch forRequestType {
        case let .cityName(city):
//            демо на день id=
            urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(city)&appid=\(apiKey)"
//            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&lang=ru&appid=\(apiKey)"
        case let .coordinate(latitude, longitude):
            urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,alerts&units=metric&lang=ru&appid=\(apiKey)"
        }
        return URL(string: urlString)
    }

    func performRequest(typeWeather: TypeModel, requestType: RequestType, completionHandler: @escaping (CityWeather?, CityWeatherLocation?) -> Void) { // fileprivate
        var url = URL(string: "")
        if typeWeather == .CityWeatherCity {
            url = fetchCityWeather(forRequestType: requestType)
        } else {
            url = fetchCityWeather(forRequestType: requestType)
        }
        guard let newUrl = url else { return }

        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: newUrl) { data, _, _ in
                if let data = data,
                    let cityWeather = self.parseJSON(withData: data, typeWeather: typeWeather) {
                    completionHandler(cityWeather.0, cityWeather.1)
                }
            }
            task.resume()
        }
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: newUrl) { data, _, _ in
//            if let data = data,
//                let cityWeather = self.parseJSON(withData: data, typeWeather: typeWeather) {
//                completionHandler(cityWeather.0, cityWeather.1)
//            }
//        }
//        task.resume()

    }

    private func parseJSON(withData data: Data, typeWeather: TypeModel) -> (CityWeather?, CityWeatherLocation?)? {
        let decoder = JSONDecoder()
        do {
            switch typeWeather {
            case .CityWeatherCity:
                let weatherData = try decoder.decode(CityWeatherCity.self, from: data)
                guard let cityWeathers = CityWeather(CityWeatherData: weatherData) else { return (nil, nil) }
                return (cityWeathers, nil)
            case .CityWeatherLocation:
                let weatherData = try decoder.decode(CityWeatherCoordinate.self, from: data)
                guard let weathers = CityWeatherLocation(weatherLocation: weatherData) else { return (nil, nil) }
                return (nil, weathers)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return (nil, nil)
    }





}
