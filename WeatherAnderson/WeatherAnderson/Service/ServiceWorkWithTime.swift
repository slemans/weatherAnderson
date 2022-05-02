//
//  ServiceWorkWithTime.swift
//  WeatherAnderson
//
//  Created by sleman on 4.04.22.
//

import UIKit

class ServiceWorkWithTime {

    static let shared = ServiceWorkWithTime()
    private init() { }

    // get Sun and Moon
    func getSunTime(time: Int?, type: Bool) -> String {
        guard let time = fetchTimeUpAndDownSunAndMoon(time) else { return " Нет данных " }
        let wordLast = type ? "Восход" : "Закат"
        return "\(time.0):\(time.1) \n \(wordLast)"
    }

    // получаю время заката и рассвета
    private func fetchTimeUpAndDownSunAndMoon(_ time: Int?) -> (Int, Int)? {
        guard let time = time else { return nil }
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateNew = date as Date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: dateNew)
        let minutes = calendar.component(.minute, from: dateNew)
        return (hour, minutes)
    }

    // день или ночь
    func fetchTimeDayOrNight(_ time: Current) -> Bool {
        guard let hour = Int(getDateOnAllDay(time: time)),
              let sunrise = fetchTimeUpAndDownSunAndMoon(time.sunrise)?.0,
              let sunset = fetchTimeUpAndDownSunAndMoon(time.sunset)?.0 else { return true }
            switch hour {
                case sunrise ... sunset: return true
                default: return false
            }
    }

    // get Time day currently
    func getDateNow(daily: Int) -> (String, String) {
        let date = NSDate(timeIntervalSince1970: TimeInterval(daily))
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru-RUS")
        dateFormater.setLocalizedDateFormatFromTemplate("MMM d, yyyy")
        let dateNew = date as Date
        let weekday = dateFormater.weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1].firstUppercased
        let dateDescription = dateFormater.string(from: dateNew)
        return (weekday, dateDescription)
    }

    // get Time all day
    func getDateOnAllDay(time: Current) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time.dt))
        let dateNew = date as Date
        let calendar = Calendar.current
        let time = calendar.component(.hour, from: dateNew)
        return String(time)
    }

    // get time for weak
    func getDateTimeWeak(daily: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(daily))
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru-RUS")
        let dateNew = date as Date
        let weekday = dateFormater.weekdaySymbols[Calendar.current.component(.weekday, from: dateNew) - 1].firstUppercased
        return weekday
    }
}
