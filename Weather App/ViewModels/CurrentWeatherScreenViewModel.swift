//
//  CurrentWeatherScreenViewModel.swift
//  Weather App
//
//  Created by Nick Nikolos on 10/12/23.
//

import Foundation

class CurrentWeatherScreenViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeatherModel?
    
    func fetchData(lat: Double, lon: Double) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(OPEN_WEATHER.API_KEY)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let weatherResults = try decoder.decode(CurrentWeatherData.self, from: safeData)
                            DispatchQueue.main.async {
                                self.currentWeather = CurrentWeatherModel(weather: weatherResults.weather, main: weatherResults.main, wind: weatherResults.wind, dt: weatherResults.dt, sys: weatherResults.sys, id: weatherResults.id, name: weatherResults.name)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
                else {
                    print("Couldn't fetch data. Error: \(error!)")
                }
            }
            task.resume()
        }
        
    }
}
