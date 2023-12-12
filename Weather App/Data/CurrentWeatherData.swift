//
//  CurrentWeatherData.swift
//  Weather App
//
//  Created by Nick Nikolos on 10/12/23.
//

import Foundation

struct CurrentWeatherData: Decodable {
    let weather: [Weather]
    let main: MainStats
    let wind: Wind
    let dt: Double
    let sys: Sys
    let id: Int
    let name: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainStats: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Sys: Decodable {
    let type: Int?
    let id: Int?
    let country: String
    let sunrise: Int
    let sunset: Int
}
