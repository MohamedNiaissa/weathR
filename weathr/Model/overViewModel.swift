//
//  overViewModel.swift
//  weathr
//
//  Created by Mohamed Niaissa on 05/10/2023.
//

import Foundation

struct Overview: Codable {
    let current: CurrentWeather
    let forecast : OverviewForecast
}

struct CurrentWeather : Codable {
    let temp_c : Double
    let feelslike_c : Double
    let condition : OverviewCondition
}

struct OverviewForecast : Codable  {
    let forecastday: [OverviewForecastDay]
}

struct OverviewForecastDay : Codable {
    let day: OverviewDay
    let hour : [OverviewHour]
    
}

struct OverviewDay : Codable {
    let maxtemp_c : Double
    let mintemp_c : Double
    let condition : OverviewCondition
}

struct OverviewHour : Codable {
    let time : String
    let temp_c : Double
    let condition : OverviewCondition
}

struct OverviewCondition : Codable {
    let text : String
    let icon : String
    let code : Int
}


