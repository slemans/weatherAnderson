//
//  ServiceApiManager.swift
//  WeatherAnderson
//
//  Created by sleman on 27.03.22.
//
import CoreLocation
import Foundation

class ServiceApiManager {
    let apiKey = "7c869b6df2587f132c69a4700c43631f"

    
    
    enum RequstType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    func fetchCityWeather(forRequestType: RequstType) -> String{
        var urlString = ""
        switch forRequestType {
        case let .cityName(city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&exclude=hourly,daily&units=metric&appid=\(apiKey)"
        case let .coordinate(latitude, longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&exclude=hourly,daily&units=metric&appid=\(apiKey)"
        }
        return urlString
    }

    public func performRequest(completionHandler: @escaping (CityWeather) -> Void) { // fileprivate
        
        let url = URL(string: fetchCityWeather(forRequestType: .cityName(city: "Minsk")))
        
        guard let url = url else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, _ in
            if let data = data, let cityWeather = self.parseJSON(withData: data) {
                completionHandler(cityWeather)
            }
        }
        task.resume()
    }

    public func parseJSON(withData data: Data) -> CityWeather? {
        let decoder = JSONDecoder()
        do {
            let cityWeatherData = try decoder.decode(CityWeatherData.self, from: data)
            guard let cityWeathers = CityWeather(CityWeatherData: cityWeatherData) else { return nil }
            return cityWeathers
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    

    

}
