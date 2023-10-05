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
