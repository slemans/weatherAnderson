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
        return array
    }

}
