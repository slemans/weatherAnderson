//
//  StringProtocol.swift
//  WeatherAnderson
//
//  Created by sleman on 28.03.22.
//

import Foundation

extension StringProtocol {
    // переход в нижний регистр
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
