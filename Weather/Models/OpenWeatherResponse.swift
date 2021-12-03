//
//  OpenWeather.swift
//  Weather
//
//  Created by Eli Hartnett on 12/1/21.
//

import Foundation

struct OpenWeatherResponse: Decodable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Double?
    var sys: Sys?
    var timezone: Int?
    var id: Int?
    var cod: Int?
}

struct Coord: Decodable {
    var lon: Double?
    var lat: Double?
}

struct Weather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Decodable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var humidity: Double?
}

struct Wind: Decodable {
    var speed: Double?
    var deg: Int?
}

struct Clouds: Decodable {
    var all: Int?
}

struct Sys: Decodable {
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}
