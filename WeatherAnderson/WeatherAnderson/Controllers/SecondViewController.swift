//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 22.03.22.
//

import UIKit
import CoreLocation
import CoreData

protocol ReloadTableWeather: AnyObject {
    func reloadTableView()
}

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
    @IBOutlet weak var stackActivity: UIStackView!
    @IBOutlet weak var saveWeatherButton: UIButton!
    @IBOutlet weak var closeViewBt: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var hourlyWeather: [Current] = []
    var dailyWeather: [Daily] = []
    var demoWeather = false
    var nameCity = ""
    var fullViewOrModal = true
    var myLocation = false
    var uniqueOrNo = true
    
    let serviceCoreDate = ServiceWorkWithCoreDate.shared
    var weatherFull: CityWeatherLocation?
    let serviceWorkWithTime = ServiceWorkWithTime.shared
    var weatherSaveCoreDate: WeatherCoreData?
    weak var delegate: ReloadTableWeather?

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkNill()
        serviceCoreDate.newWeatherOrNo(nameCity) { [weak self] value in
            self?.saveWeatherButton.isHidden = value
            self?.uniqueOrNo = !value
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if myLocation && uniqueOrNo {
            serviceCoreDate.saveNewWeatherInCoreDate(weatherFull, nameCity)
            delegate?.reloadTableView()
        }
    }
    
    @IBAction func returnMainView() {
        navigationBackToMainView()
    }

    @IBAction func saveWeather() {
        serviceCoreDate.saveNewWeatherInCoreDate(weatherFull, nameCity)
        navigationBackToMainView()
        delegate?.reloadTableView()
    }
    
    func getLatAndLon(_ city: City?) {
        if let selectedCity = city {
            nameCity = selectedCity.name
            demoWeather = false
            ServiceApiManager.shared.performRequest(requestType: .coordinate(latitude: selectedCity.lat, longitude: selectedCity.lon)) { [weak self] weatherLocation in
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
}







