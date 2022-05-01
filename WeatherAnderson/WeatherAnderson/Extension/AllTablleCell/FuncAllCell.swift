//
//  funcAllCell.swift
//  WeatherAnderson
//
//  Created by sleman on 2.05.22.
//

import UIKit

class FuncAllCell{
    static let shared = FuncAllCell()
    private init() { }
    func getBackground(item: CityWeatherLocation) -> String {
        let cloud = ServiceWorkWithTime.shared.fetchTimeDayOrNight(item.current)
        let background = BackgroundCell(background: item.daily[0].weather[0].id, dayOrNightSelect: cloud)
        return background.imageBackground
    }
}

