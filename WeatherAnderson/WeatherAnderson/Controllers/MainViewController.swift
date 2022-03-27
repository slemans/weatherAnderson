//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 22.03.22.
//

import UIKit
import CoreLocation
import CoreData

class MainViewController: UIViewController {

    @IBOutlet var mainViewMy: UIView!
    @IBOutlet weak var collectionStackView: UIStackView!
    @IBOutlet weak var temperatureStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackViewForecast: UIStackView!
    
    let serviceApiManager = ServiceApiManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        serviceApiManager.performRequest { cityWeather in
            print(cityWeather)
        }
        
    }
    

    
    
    
    
    func startSetting(){
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        temperatureStackView.addRightBorderWithColor(color: .white, width: 1)
        stackViewForecast.addBottomBorderWithColor(color: .white, width: 1)
        
    }


 

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
//        let dayHourly = hourlyWeather[indexPath.row]
//        let dateStrings = getDateNow(daily: dayHourly)
//        cell.timeLb.text = dateStrings
//        cell.fenchHourly(forWeather: dayHourly)
        cell.temperatureLb.text = "10"
        cell.timeLb.text = "10:00"
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        return cell
    }
}
