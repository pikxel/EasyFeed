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
    private var jsonPlaceHolderBase: String {
        return "http://jsonplaceholder.typicode.com"
    }

    var baseURL: URL? {
        switch self {
        case .weather:
            switch environment {
            case .production:
                return URL(string: jsonPlaceHolderBase)
            }
        }
    }

    var environment: NetworkEnvironmentType {
        return .production
    }
}
