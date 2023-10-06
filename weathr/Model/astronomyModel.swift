//
//  astronomyModel.swift
//  weathr
//
//  Created by Mohamed Niaissa on 05/10/2023.
//

import Foundation


struct Astronomy: Codable {
    let astronomy: AstroData
}

struct AstroData: Codable {
    let astro: Astro
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moon_phase: String
    let is_moon_up: Int
    let is_sun_up: Int
}
