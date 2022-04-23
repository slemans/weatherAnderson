//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 22.03.22.
//

import UIKit
import CoreLocation
import CoreData

class SecondViewController: UIViewController {

    @IBOutlet var mainViewMy: UIView!
    @IBOutlet weak var collectionStackView: UIStackView!
    @IBOutlet weak var temperatureStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temperatureLabelMain: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stackViewForecast: UIStackView!
    @IBOutlet weak var iconMainWether: UIImageView!
    @IBOutlet weak var descriptionWeatherLabelMain: UILabel!
    @IBOutlet weak var dayWetherLabel: UILabel!
    @IBOutlet weak var timeWetherLabel: UILabel!
    @IBOutlet weak var stackViewCollectionViewTwo: UIStackView!
    @IBOutlet weak var feelLike: UILabel!
    @IBOutlet weak var pressureLb: UILabel!
    @IBOutlet weak var cloudsLb: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibilityLb: UILabel!
    @IBOutlet weak var stackViewLast: UIStackView!
    @IBOutlet weak var sunDownLb: UILabel!
    @IBOutlet weak var sunUpLb: UILabel!
    @IBOutlet weak var mainStackFirst: UIStackView!
    @IBOutlet weak var collectionMain: UIScrollView!
    @IBOutlet weak var stackError: UIStackView!
    @IBOutlet weak var stackActivity: UIStackView!
    
    var hourlyWeather: [Current] = []
    var dailyWeather: [Daily] = []
    var demoWeather = false
    var newOrNoWeather = true
    var nameCity = ""
    
    var weatherFull: CityWeatherLocation?
    let serviceWorkWithTime = ServiceWorkWithTime()
    
    var weatherSaveCoreDate: WeatherCoreData?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        if demoWeather{
            stackActivity.isHidden = true
            collectionMain.isHidden = true
            mainStackFirst.isHidden = true
            stackError.isHidden = false
        }
    }


    @IBAction func btReturnToTableView() {
        navigationController?.popViewController(animated: true)
        saveNewWeatherInCoreDate()
        dismiss(animated: true, completion: nil)
    }
    
    func saveNewWeatherInCoreDate(){
        if !newOrNoWeather{
            let newWetherToCoreDate = WeatherCoreData(context: ServiceWorkWithCoreDate.context)
            guard let weatherFull = weatherFull else { return }
            newWetherToCoreDate.name = nameCity
            newWetherToCoreDate.background = getBackground(item: weatherFull)
            newWetherToCoreDate.lon = weatherFull.lon
            newWetherToCoreDate.lat = weatherFull.lat
            ServiceWorkWithCoreDate.saveInCoreData()
        }
    }
    
    // фон для cell
    func getBackground(item: CityWeatherLocation) -> String{
        let background = BackgroundCell(background: item.daily[0].weather[0].id)
        return background.imageBackground
    }

    func getLatAndLon(_ city: City?) {
        if let selectedCity = city {
            nameCity = selectedCity.name
            demoWeather = false
            ServiceApiManager.shared.performRequest(typeWeather: .CityWeatherLocation, requestType: .coordinate(latitude: selectedCity.lat, longitude: selectedCity.lon)) { [weak self] _, weatherLocation in
                guard let weatherLocation = weatherLocation else { return }
                
                self?.weatherFull = weatherLocation
                self?.hourlyWeather = weatherLocation.hourly
                self?.dailyWeather = weatherLocation.daily
                DispatchQueue.main.async {
                    self?.stackActivity.isHidden = true
                    self?.cityLabel.text = selectedCity.name
                    self?.fillWetherLocal(weather: weatherLocation)
                    self?.collectionView.reloadData()
                    self?.tableView.reloadData()
                }
            }
        } else {
            demoWeather = true
        }
    }

    private func startSetting() {
        stackActivity.alpha = 0.9
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        temperatureStackView.addRightBorderWithColor(color: .white, width: 1)
        stackViewForecast.addBottomBorderWithColor(color: .white, width: 1)
        stackViewCollectionViewTwo.addBottomBorderWithColor(color: .white, width: 1)
        stackViewLast.addBottomBorderWithColor(color: .white, width: 1)
    }

}

// setting weatherLocal
extension SecondViewController {

    private func fillWetherLocal(weather: CityWeatherLocation) {
        temperatureLabelMain.text = weather.temperature
        iconMainWether.image = UIImage(named: weather.current.weather.first!.systemIconNameString)
        descriptionWeatherLabelMain.text = weather.current.weather.first?.newDescription.firstUppercased
        dayWetherLabel.text = serviceWorkWithTime.getDateNow(daily: weather.dt).0
        timeWetherLabel.text = serviceWorkWithTime.getDateNow(daily: weather.dt).1
        feelLike.text = weather.current.feelString
        pressureLb.text = weather.current.pressureString
        cloudsLb.text = weather.current.cloudsString
        visibilityLb.text = weather.current.visibilityString
        humidity.text = weather.current.humidityString
        sunUpLb.text = serviceWorkWithTime.getSunTime(time: weather.current.sunrise, type: true)
        sunDownLb.text = serviceWorkWithTime.getSunTime(time: weather.current.sunset, type: false)
    }
}


extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return hourlyWeather.count - 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        let dayHourly = hourlyWeather[indexPath.row]
        cell.timeLb.text = serviceWorkWithTime.getDateOnAllDay(time: dayHourly)
        cell.fetchHourly(forWeather: dayHourly)
        return cell
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dailyWeather.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        let day = dailyWeather[indexPath.row]
        cell.fetchDaily(forWeather: day)
        return cell
    }
}
