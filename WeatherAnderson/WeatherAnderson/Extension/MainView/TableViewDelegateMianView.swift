//
//  TableViewDelegateMianView.swift
//  WeatherAnderson
//
//  Created by sleman on 3.05.22.
//

import UIKit
import CoreData

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showCityArrayOrWeather {
            return weatherCoreDataArray.count
        } else {
            return filterArrayCity.count != 0 ? filterArrayCity.count : arrayCity.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showCityArrayOrWeather {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell", for: indexPath) as! WeatherTableViewCell
            cell.isHidden = false
            let weather = weatherCoreDataArray[indexPath.row]
            cell.fetchAndPutUI(weather)
            return cell
        } else {
            var city: City!
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityTableViewCell", for: indexPath) as! CityTableViewCell
            city = filterArrayCity.count != 0 ? filterArrayCity[indexPath.row] : arrayCity[indexPath.row]
            cell.startSetting(text: city.name)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var city: City!
        if showCityArrayOrWeather {
            let weather = weatherCoreDataArray[indexPath.row]
            city = City(weather.name!, weather.lon, weather.lat)
        } else {
            city = !filterArrayCity.isEmpty ? filterArrayCity[indexPath.row] : arrayCity[indexPath.row]
        }
        myLocationOrNo = false
        prepareSegueNextView(city)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let categoryDelete = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, _ in
            if let name = self?.weatherCoreDataArray[indexPath.row].name {
                let request: NSFetchRequest<WeatherCoreData> = WeatherCoreData.fetchRequest()
                let itemPredicate = NSPredicate(format: "name MATCHES %@", name)
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [itemPredicate])
                if let allWeather = try? ServiceWorkWithCoreDate.shared.getContext().fetch(request) {
                    for item in allWeather {
                        ServiceWorkWithCoreDate.shared.getContext().delete(item)
                    }
                    self?.weatherCoreDataArray.remove(at: indexPath.row)
                    ServiceWorkWithCoreDate.shared.saveInCoreData()
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        categoryDelete.image = #imageLiteral(resourceName: "cartmTwo")
        categoryDelete.backgroundColor = .black
        let swipeActions = UISwipeActionsConfiguration(actions: [categoryDelete])
        return swipeActions
    }
}
