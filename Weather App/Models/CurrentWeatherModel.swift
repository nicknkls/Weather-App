//
//  CurrentWeatherModel.swift
//  Weather App
//
//  Created by Nick Nikolos on 10/12/23.
//

import Foundation

struct CurrentWeatherModel {
    let weather: [Weather]
    let main: MainStats
    let wind: Wind
    let dt: Double
    let sys: Sys
    let id: Int
    let name: String
    
    //MARK: - country
    var country: String {
        return Locale.current.localizedString(forRegionCode: sys.country) ?? ""
    }
    
    //MARK: - currentDay
    var currentDay: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        let dateString = formatter.string(from: date as Date)
        let dateArr = dateString.split(separator: ",")
        return String(dateArr[0])
    }
    
    //MARK: - currentTime
    var currentTime: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date as Date)
    }
    
    //MARK: - greeting
    var greeting: String {
        let amPm = currentTime.split(separator: " ")
        if String(amPm[1]) == "AM" {
            return "Good morning"
        } else {
            return "Good evening"
        }
    }
    
    //MARK: - appTheme
    var appTheme: APP_THEME {
        let amPm = currentTime.split(separator: " ")
        print(amPm[1])
        if String(amPm[1]) == "AM" {
            return .LIGHT
        } else {
            return .DARK
        }
    }
    
    //MARK: - sunsetTime
    var sunsetTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(sys.sunset))
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date as Date)
    }
    
    //MARK: - getTemperature
    func getTemperature(kelvin: Double) -> String {
        if sys.country == "US" {
            return "\(Int(kelvin - 273.15) * 9/5 + 32)℉"
        } else {
            return "\(Int(kelvin - 273.15))℃"
        }
    }
}
