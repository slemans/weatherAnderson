//
//  ServiceWorkWithCoreDate.swift
//  WeatherAnderson
//
//  Created by sleman on 18.04.22.
//

import CoreData
import UIKit

class ServiceWorkWithCoreDate{
    
    static let context = ServiceWorkWithCoreDate.getContext()
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func saveInCoreData() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    static func getWeatherArray() -> [WeatherCoreData]? {
        let request: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
        var array: [WeatherCoreData] = []
        do {
            array = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        // костыль для вставки значения в первый индекс
        var number = 0
        for (index, item) in array.enumerated(){
            if item.name == "Моя локация"{
                number = index
            }
        }
        let newItem = array.remove(at: number)
        array.insert(newItem, at: 0)
        return array
    }
    
    // сохранение нового элемента в CoreDate
    func saveNewWeatherInCoreDate(_ cityWeather: CityWeatherLocation?, _ cityName: String) {
        let newWetherToCoreDate = WeatherCoreData(context: ServiceWorkWithCoreDate.context)
        guard let weatherFull = cityWeather else { return }
        newWetherToCoreDate.name = cityName
        newWetherToCoreDate.background = getBackground(item: weatherFull)
        newWetherToCoreDate.lon = weatherFull.lon
        newWetherToCoreDate.lat = weatherFull.lat
        ServiceWorkWithCoreDate.saveInCoreData()
    }
    // фон для cell
    private func getBackground(item: CityWeatherLocation) -> String {
        let background = BackgroundCell(background: item.daily[0].weather[0].id)
        return background.imageBackground
    }
    // проверка есть ли уже такой город в CoreDate
    func newWeatherOrNo(_ cityName: String, completion: @escaping (Bool) -> Void){
        let request: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
        let itemPredicate = NSPredicate(format: "name MATCHES %@", cityName)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [itemPredicate])
        if let allWeather = try? ServiceWorkWithCoreDate.context.fetch(request),
            allWeather.count > 0 {
                completion(true)
            }
    }
}
