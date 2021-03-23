//
//  ResponseResult.swift
//  ManiacWeather
//
//  Created by Peter Lizak on 15/01/2020.
//  Copyright © 2020 Peter Lizak. All rights reserved.
//

import Foundation

enum HTTPResponseResult {
    case success, failure(String)
}
