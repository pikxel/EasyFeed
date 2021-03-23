//
//  APIConfig.swift
//  ManiacWeather
//
//  Created by Peter Lizak on 10/01/2020.
//  Copyright © 2020 Peter Lizak. All rights reserved.
//

import Foundation

public enum HTTPMethodType: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
}

protocol APIProtocol {
    func httpMthodType() -> HTTPMethodType
    func apiEndPath() -> String
    func apiBasePath() -> String
}

protocol APIModelType {
    var api: APIProtocol { get set }
    var parameters: [String: Any]? { get set }
}

struct APIRequestModel: APIModelType {
    var api: APIProtocol
    var parameters: [String: Any]?

    init(api: APIProtocol, parameters: [String: Any]? = nil) {
        self.api = api
        self.parameters = parameters
    }
}

struct WebserviceConfig {
    func generateHeader() -> [String: String] {
        var headerDict = [String: String]()
        headerDict["Content-Type"] = "application/json"

        return headerDict
    }
}
