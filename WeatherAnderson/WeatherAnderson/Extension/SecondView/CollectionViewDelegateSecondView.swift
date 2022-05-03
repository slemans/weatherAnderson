//
//  CollectionViewDelegateSecondView.swift
//  WeatherAnderson
//
//  Created by sleman on 26.04.22.
//

import UIKit

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return hourlyWeather.count - 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        let dayHourly = hourlyWeather[indexPath.row]
        cell.fetchHourly(forWeather: dayHourly)
        return cell
    }
}
