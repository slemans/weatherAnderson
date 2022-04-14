//
//  TableViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 6.04.22.
//

import UIKit
import CoreLocation

class TableViewController: UITableViewController {
    
    @IBOutlet weak var search: UISearchBar!
    
    var arrayAll: [CityWeatherLocation] = []
    
    let classArrayCity = ArrayCity()
    var arrayCity: [City] = []
    var filterArrayCity: [City] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        arrayCity = classArrayCity.arrayCity
        search.showsCancelButton = false
        if CLLocationManager.locationServicesEnabled() {
//            performSegue(withIdentifier: "segueCell", sender: nil)
        }
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//arrayAll.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as! WeatherTableViewCell
     cell.descriptionWeatherLb.text = "Облочно"
     cell.cityWeatherLb.text = "Минск"
     cell.temperatureLb.text = "20.2°"
//        if let cell = cell as? SomeCell {
//                cell.textLabel = someObject.someText // плохо
//                cell.numberLabel = someObject.someNumber // плохо
//                cell.configureForObject(someObject) // хорошо
//            } else if let cell = cell as? OtherCell {
//                cell.textLabel = otherObject.text // плохо
//                cell.numberLabel = otherObject.number // плохо
//                cell.configureForObject(otherObject) // хорошо
//            }
        return cell
    }
    



 
    
}

extension TableViewController: UISearchBarDelegate {

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterArrayCity = arrayCity.filter { item in
            let tmp: NSString = item.name as NSString
            let range = tmp.range(of: searchText)
            return range.location != NSNotFound
            }
        
        //        filterArrayCity = arrayCity.filter({ item in
//            let tmp: NSString = text
//        })
//            filtered = data.filter({ (text) -> Bool in
//                let tmp: NSString = text
//                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//                return range.location != NSNotFound
//            })
//            if(filtered.count == 0){
//                searchActive = false;
//            } else {
//                searchActive = true;
//            }
//            self.tableView.reloadData()
        }
}
