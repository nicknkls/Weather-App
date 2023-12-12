//
//  Configuration.swift
//  Weather App
//
//  Created by Nick Nikolos on 10/12/23.
//

import Foundation

private enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum OPEN_WEATHER {
    static var API_KEY: String {
        do {
            return try Configuration.value(for: "OPEN_WEATHER_API_KEY")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

enum APP_THEME: String {
    case LIGHT
    case DARK
}
