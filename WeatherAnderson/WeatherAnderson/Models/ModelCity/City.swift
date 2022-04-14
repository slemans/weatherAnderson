//
//  City.swift
//  WeatherAnderson
//
//  Created by sleman on 11.04.22.
//

import Foundation

struct City: Decodable {
    let name: String
    let lon, lat: Double

    init(_ name: String, _ lon: Double, _ lat: Double) {
        self.name = name
        self.lon = lon
        self.lat = lat
    }
}


