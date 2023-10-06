//
//  hourViewModel.swift
//  weathr
//
//  Created by Mohamed Niaissa on 06/10/2023.
//

import Foundation

struct HourWeather : Codable {
    let forecast : HourForcast
}

struct HourForcast : Codable {
    let forecastday : [HourForcastDay]
}

struct HourForcastDay : Codable {
    let hour : [InfoHourForcastHours]
}

struct InfoHourForcastHours : Codable {
    let time : String
    let temp_c : Double
    let condition : ForecastHourCondition
}

struct ForecastHourCondition : Codable {
    let icon : String
}
