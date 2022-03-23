//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 22.03.22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainViewMy: UIView!
    @IBOutlet weak var collectionStackView: UIStackView!
    @IBOutlet weak var temperatureStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        
    }
    func startSetting(){
        collectionView.dataSource = self
        collectionView.delegate = self
        temperatureStackView.addRightBorderWithColor(color: .white, width: 1)
        collectionStackView.addBottomBorderWithColor(color: .white, width: 1)
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
