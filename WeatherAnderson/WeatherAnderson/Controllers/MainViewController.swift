//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 14.04.22.
//

import UIKit
import CoreLocation
import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let classArrayCity = ArrayCity()
    var arrayCity: [City] = []
    var filterArrayCity: [City] = []
    var weatherCoreDataArray: [WeatherCoreData] = []
    var showCityArrayOrWeather = true
    var myLocationOrNo = false



    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()



    var cityWeatherLocationArray: [CityWeatherLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first as? UITouch{
//            view.endEditing(true)
//        }
//        super.touchesBegan(touches, with: event)
//    }
    

   
    
    override func viewWillAppear(_ animated: Bool) {
        loadWeather()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController {
            if showCityArrayOrWeather {
                secondVC.modalPresentationStyle = .fullScreen
                secondVC.fullViewOrModal = showCityArrayOrWeather
            } else {
                secondVC.fullViewOrModal = false
            }
            secondVC.myLocation = myLocationOrNo
            secondVC.view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            secondVC.getLatAndLon(sender as? City)
            secondVC.delegate = self
        }
    }
    private func loadWeather() {
        if let weatherArray = ServiceWorkWithCoreDate.shared.getWeatherArray() {
            weatherCoreDataArray = weatherArray
            reloadTable()
        }
    }
    private func prepareSegueNextView(_ city: City?) {
        performSegue(withIdentifier: "segueCell", sender: city)
    }
    func reloadTable() {
        cityTableView.reloadData()
    }
    func showOrDisappearSearchBarOneSelect() {
        searchBar.showsCancelButton = false
        showCityArrayOrWeather = true
        view.endEditing(true)
    }
    func showOrDisappearSearchBarTwoSelect() {
        searchBar.showsCancelButton = true
        showCityArrayOrWeather = false
    }
    private func startSetting() {
        searchBar.searchTextField.textColor = .white
        arrayCity = classArrayCity.arrayCity
    }


}

extension MainViewController: ReloadTableWeather {
    func reloadTableView() {
        myLocationOrNo = false
        showOrDisappearSearchBarOneSelect()
        loadWeather()
    }
}

//extension MainViewController {
//    private func startKeyboardObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
//                                               name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
//                                               name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardSize =
//            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//        cityTableView.contentInset = contentInsets
//        cityTableView.scrollIndicatorInsets = contentInsets
//    }
//
//    @objc func keyboardWillHide() {
//        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        cityTableView.contentInset = contentInsets
//        cityTableView.scrollIndicatorInsets = contentInsets
//    }
//
//}




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


// работа с получением координат
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let city = City("Моя локация", longitude, latitude)
        myLocationOrNo = true
        prepareSegueNextView(city)
    }
    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        myLocationOrNo = false
        prepareSegueNextView(nil)
    }
}



