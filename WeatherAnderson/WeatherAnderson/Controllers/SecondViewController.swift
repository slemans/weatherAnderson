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

    var weatherCity: CityWeather?
    var hourlyWeather: [Current] = []
    var dailyWeather: [Daily] = []
    

    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    let serviceWorkWithTime = ServiceWorkWithTime()


    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }


    @IBAction func btReturnToTableView() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }


    private func startSetting() {
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

extension SecondViewController: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        ServiceApiManager.shared.performRequest(typeWeather: .CityWeatherLocation, requestType: .coordinate(latitude: latitude, longitude: longitude)) { [weak self] _, weatherLocation in
            guard let weatherLocation = weatherLocation else { return }
            self?.hourlyWeather = weatherLocation.hourly
            self?.dailyWeather = weatherLocation.daily
            DispatchQueue.main.async {
                //                self.fillMainWether(weather: weatherCity)
//                SettingCoreDate.writeNewDate(weather: cityWeather)
                self?.fillWetherLocal(weather: weatherLocation)
                self?.collectionView.reloadData()
                self?.tableView.reloadData()
            }
        }
        
//        ServiceApiManager.shared.performRequest(typeWeather: .CityWeatherCity, requestType: .cityName(city: "833")) { [weak self] weather, _ in
//            guard let weatherLocation = weather else { return }
//            self?.weatherCity = weatherLocation
//            print(weather?.cityName)
//            DispatchQueue.main.async {
//                self?.fillMainWether(weather: weatherLocation)
//            }
//        }
    }
    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}




// setting weatherLocal
extension SecondViewController {

    private func fillWetherLocal(weather: CityWeatherLocation) {
        temperatureLabelMain.text = weather.temperature
        iconMainWether.image = UIImage(named: weather.current.weather.first!.systemIconNameString)
        cityLabel.text = weather.nameCity
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



// setting weatherCity
extension SecondViewController {
    private func fillMainWether(weather: CityWeather) {
        temperatureLabelMain.text = weather.temperatureString
        cityLabel.text = weather.cityName
        descriptionWeatherLabelMain.text = weather.weatherDescription.firstUppercased
        iconMainWether.image = UIImage(named: weather.systemIconNameString)
        dayWetherLabel.text = serviceWorkWithTime.getDateNow(daily: weather.dt).0
        timeWetherLabel.text = serviceWorkWithTime.getDateNow(daily: weather.dt).1
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
