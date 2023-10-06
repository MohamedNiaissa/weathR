//
//  detailsModel.swift
//  weathr
//
//  Created by Mohamed Niaissa on 05/10/2023.
//

import Foundation


struct WeatherDetails : Codable{
    let current : WeatherInfos
}

struct WeatherInfos : Codable {
    let pressure_in: Double
    let wind_kph: Double
    let wind_dir: String
    let humidity: Int
    let uv: Double
    let precip_mm: Double
    let cloud: Int
    let vis_km: Double
}
