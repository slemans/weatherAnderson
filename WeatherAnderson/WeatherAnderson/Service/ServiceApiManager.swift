//
//  ServiceApiManager.swift
//  WeatherAnderson
//
//  Created by sleman on 27.03.22.
//
import CoreLocation
import Foundation

class ServiceApiManager {
    static let shared = ServiceApiManager()
    private init() { }

    let apiKey = "7c869b6df2587f132c69a4700c43631f"

    enum RequestType {
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }

    private func fetchCityWeather(forRequestType: RequestType) -> URL? {
        var urlString = ""
        switch forRequestType {
        case let .coordinate(latitude, longitude):
            urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,alerts&units=metric&lang=ru&appid=\(apiKey)"
        }
        return URL(string: urlString)
    }

    func performRequest(requestType: RequestType, completionHandler: @escaping (CityWeatherLocation?) -> Void) { // fileprivate
        let url = fetchCityWeather(forRequestType: requestType)
        guard let newUrl = url else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: newUrl) { data, _, _ in
            if let data = data,
                let cityWeather = self.parseJSON(withData: data) {
                completionHandler(cityWeather)
            }
        }
        task.resume()
    }

    private func parseJSON(withData data: Data) -> CityWeatherLocation? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(CityWeatherCoordinate.self, from: data)
            guard let weathers = CityWeatherLocation(weatherLocation: weatherData) else { return nil }
            return weathers
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
