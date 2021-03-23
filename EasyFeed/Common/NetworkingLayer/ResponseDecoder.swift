//
//  ResponseDecoder.swift
//  ManiacWeather
//
//  Created by Peter Lizak on 10/01/2020.
//  Copyright © 2020 Peter Lizak. All rights reserved.
//

import Foundation

class JSONResponseDecoder {

    typealias JSONDecodeCompletion<T> = (T?, Error?) -> Void

    static func decodeFrom<T: Decodable>(_ responseData: Data,
                                         returningModelType: T.Type, completion: JSONDecodeCompletion<T>) {
        do {
            let model = try JSONDecoder().decode(returningModelType, from: responseData)
            completion(model, nil)
        } catch let DecodingError.dataCorrupted(context) {
            Log.error("Data corrupted: \(context)")
            completion(nil, DecodingError.dataCorrupted(context))
        } catch let DecodingError.keyNotFound(key, context) {
            Log.error("Key \(key) not found: \(context.debugDescription) \n codingPath: \(context.codingPath)")
            completion(nil, DecodingError.keyNotFound(key, context))
        } catch let DecodingError.valueNotFound(value, context) {
            Log.error("Value \(value) not found: \(context.debugDescription) \n codingPath: \(context.codingPath)")
            completion(nil, DecodingError.valueNotFound(value, context))
        } catch let DecodingError.typeMismatch(type, context) {
            Log.error("Type \(type) mismatch: \(context.debugDescription) \n codingPath: \(context.codingPath)")
            completion(nil, DecodingError.typeMismatch(type, context))
        } catch {
            Log.error("error \(error.localizedDescription)")
            completion(nil, error)
        }
    }
}
