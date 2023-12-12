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
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=8372757c26080a5e4c270e25eac1b665") {
            print("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=8372757c26080a5e4c270e25eac1b665")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let weatherResults = try decoder.decode(CurrentWeatherData.self, from: safeData)
                            DispatchQueue.main.async { //When setting data to published -> must be on Main thread!
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
