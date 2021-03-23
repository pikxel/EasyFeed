//
//  HTTPError.swift
//  ManiacWeather
//
//  Created by Peter Lizak on 12/01/2020.
//  Copyright © 2020 Peter Lizak. All rights reserved.
//

import Foundation

enum HTTPResponseDescription: String {
    case success
    case unableToParseURLResponse = "Unable to convert URLResponse to HTTPURLResponse. URLResponse may be nil"
    case wrongStatusCode = "Status code do not match with the expected status code"
    case authenticationError = "You need to be authenticated first."
    case unableToBuildRequest = "Unable to build the request."
    case unableToDecode = "We could not decode the response."
    case noData = "Response returned with no data to decode."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case badRequest = "Bad request"
}
