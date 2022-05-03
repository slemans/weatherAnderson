//
//  ServiceWorkWithCoreDate.swift
//  WeatherAnderson
//
//  Created by sleman on 18.04.22.
//

import CoreData
import UIKit

class ServiceWorkWithCoreDate{
    static let shared = ServiceWorkWithCoreDate()
    private init() { }
    
    
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveInCoreData() {
        do {
            try getContext().save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func getWeatherArray() -> [WeatherCoreData]? {
        let request: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
        var array: [WeatherCoreData] = []
        do {
            array = try getContext().fetch(request)
            
        } catch {
            print("Error fetching data from context: \(error)")
        }
        
        // костыль для вставки Моя локация в первый индекс
        if array.count > 0{
            var number = 0
            for (index, item) in array.enumerated(){
                if item.name == "Моя локация"{
                    number = index
                }
            }
            let newItem = array.remove(at: number)
            array.insert(newItem, at: 0)
        }
        return array
    }
    
    // сохранение нового элемента в CoreDate
    func saveNewWeatherInCoreDate(_ cityWeather: CityWeatherLocation?, _ cityName: String) {
        let newWetherToCoreDate = WeatherCoreData(context: getContext())
        guard let weatherFull = cityWeather else { return }
        newWetherToCoreDate.name = cityName
        newWetherToCoreDate.background = FuncAllCell.shared.getBackground(item: weatherFull)
        newWetherToCoreDate.lon = weatherFull.lon
        newWetherToCoreDate.lat = weatherFull.lat
        saveInCoreData()
    }
    
    // проверка есть ли уже такой город в CoreDate
    func newWeatherOrNo(_ cityName: String, completion: @escaping (Bool) -> Void){
        let request: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
        let itemPredicate = NSPredicate(format: "name MATCHES %@", cityName)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [itemPredicate])
        if let allWeather = try? getContext().fetch(request),
            allWeather.count > 0 {
                completion(true)
            }
    }
}
