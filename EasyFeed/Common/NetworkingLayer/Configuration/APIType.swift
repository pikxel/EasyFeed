//
//  APIType.swift
//  ManiacWeather
//
//  Created by Peter Lizak on 12/01/2020.
//  Copyright © 2020 Peter Lizak. All rights reserved.
//

import Foundation

enum APIType {
    case weather
}

extension APIType {
    private var weatherAPIBaseURL: String {
        return "https://api.openweathermap.org"
    }

    var baseURL: URL? {
        switch self {
        case .weather:
            switch environment {
            case .production:
                return URL(string: weatherAPIBaseURL)
            }
        }
    }

    var environment: NetworkEnvironmentType {
        return .production
    }
}
