//
//  searchViewModel.swift
//  weathr
//
//  Created by Mohamed Niaissa on 04/10/2023.
//

import Foundation

struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast : Forecast
}

struct Location: Codable {
    let name: String
    let region: String
}

struct Current: Codable {
    let temp_c: Double
    let condition: Condition
}

struct Forecast : Codable  {
    let forecastday: [ForecastDay]
}

struct ForecastDay : Codable  {
    let date: String
    let day: Day
}

struct Day : Codable  {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: Condition
}

struct Condition : Codable  {
    let text: String
    let icon: String
}
