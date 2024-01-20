//
//  HomeScreenView.swift
//  Weather App
//
//  Created by Nick Nikolos on 10/12/23.
//

import SwiftUI

struct CurrentWeatherScreenView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = CurrentWeatherScreenViewModel()
    @State var isLoading = true
    
    var body: some View {
        VStack {
            if (isLoading) {
                ProgressView()
            } else {
                //Location - Date Info
                VStack {
                    //Location name
                    Text(viewModel.currentWeather?.name ?? "")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                    //Country name
                    Text(viewModel.currentWeather?.country ?? "")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                    //Day & Time
                    HStack {
                        Text(viewModel.currentWeather?.currentDay ?? "")
                            .font(.subheadline)
                            .foregroundStyle(Color.white)
                        Text(viewModel.currentWeather?.currentTime ?? "")
                            .font(.subheadline)
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.vertical)
                
                //Weather Conditions Image
                if let weatherId = viewModel.currentWeather?.weather[0].id {
                    Image(systemName: viewModel.currentWeather?.weatherIcon(weatherConditionId: weatherId) ?? "sun.max.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            LinearGradient(colors: [.white, .white], startPoint: UnitPoint(x: 0.7, y: 0.7), endPoint: UnitPoint(x: 0.9, y: 0.9)),
                            .yellow
                        )
                        .font(.system(size: 100))
                }
                
                VStack {
                    //Temperature
                    Text(viewModel.currentWeather?.getTemperature(kelvin: viewModel.currentWeather?.main.temp ?? 0) ?? "")
                    //.font(.largeTitle)
                        .font(.system(size: 80))
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.white)
                    
                    //Greeting
                    Text(viewModel.currentWeather?.greeting ?? "")
                        .foregroundStyle(Color.white)
                }
                .padding(.bottom)
                
                Divider()
                    .background(Color.gray)
                //Extra Info
                HStack {
                    VStack(alignment: .leading) {
                        Text("Sunset")
                            .foregroundStyle(Color.white)
                        Text(viewModel.currentWeather?.sunsetTime ?? "")
                            .foregroundStyle(Color.white)
                    }
                    Divider()
                        .frame(height: 25)
                        .background(Color.gray)
                    
                    VStack(alignment: .leading) {
                        Text("Wind")
                            .foregroundStyle(Color.white)
                        Text("\(String(format: "%.2f", viewModel.currentWeather?.wind.speed ?? 0)) m/s")
                            .foregroundStyle(Color.white)
                    }
                    Divider()
                        .frame(height: 25)
                        .background(Color.gray)
                    
                    VStack(alignment: .leading) {
                        Text("Max Temp")
                            .foregroundStyle(Color.white)
                        Text(viewModel.currentWeather?.getTemperature(kelvin: viewModel.currentWeather?.main.temp_max ?? 0) ?? "")
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.vertical)
            }
        }
        .animation(.easeInOut)
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .padding()
        .background(viewModel.currentWeather?.appTheme == .LIGHT ? .day : .night)
        .task {
            viewModel.fetchData(lat: locationManager.lastLocation?.coordinate.latitude ?? 0, lon: locationManager.lastLocation?.coordinate.longitude ?? 0)
            
            isLoading = false
        }
    }
}

#Preview {
    CurrentWeatherScreenView()
}
