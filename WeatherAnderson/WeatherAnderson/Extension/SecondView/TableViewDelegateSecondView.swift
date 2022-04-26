//
//  TableViewDelegateSecondView.swift
//  WeatherAnderson
//
//  Created by sleman on 26.04.22.
//

import UIKit

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
