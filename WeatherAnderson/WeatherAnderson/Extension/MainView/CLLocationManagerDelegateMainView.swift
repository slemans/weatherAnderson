//
//  CLLocationManagerDelegateMainView.swift
//  WeatherAnderson
//
//  Created by sleman on 3.05.22.
//

import UIKit
import CoreLocation
import CoreData


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
