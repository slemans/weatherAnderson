//
//  CityWeatherIcon.swift
//  WeatherAnderson
//
//  Created by sleman on 29.03.22.
//

import Foundation

struct CityWeatherIcon {
    private let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200 ... 232: return "10.png"
        case 300 ... 321: return "2.png"
        case 500 ... 504: return "9.png"
        case 511: return "4.png"
        case 520 ... 531: return "2.png"
        case 600 ... 622: return "4.png"
        case 701 ... 781: return "17.png"
        case 800: return "5.png"
        case 801: return "6.png"
        case 802: return "13.png"
        case 803: return "11.png"
        case 804: return "11.png"
        default:
            return "13.png"
        }
    }
    init(CityWeatherIcon: Int) {
        conditionCode = CityWeatherIcon
    }
}

struct BackgroundCell {
    private let code: Int
    var imageBackground: String {
        switch code {
            case 200 ... 232: return "dayCloud.png"
            case 300 ... 321: return "dayCloud.png"
            case 500 ... 531: return "dayCloud.png"
            case 600 ... 622: return "dayCloud.png"
            default: return "dayClear.png"
        }
    }
    init(background: Int) {
        code = background
    }
}
