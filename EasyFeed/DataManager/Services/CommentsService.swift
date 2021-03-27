//
//  CommentsService.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation

class NetowrkService<T: Codable> {
    func loadData(completionBlock: @escaping (T?, Error?) -> Void) {
        // To be overriden
    }
}

class CommentsService: NetowrkService<[Comment]> {
    private let dashboardPath = "comments"

    override func loadData(completionBlock: @escaping  ([Comment]?, Error?) -> Void) {
        let endPoint = EndPoint<[Comment]>(urlParameter: nil,
                                         expectedResponseType: [Comment].self,
                                         expectedResponseCode: 200,
                                         path: dashboardPath,
                                         api: .weather)
        APIService().perform(endPoint: endPoint, completion: { success, data, error  in
            if success {
                completionBlock(data, nil)
            } else {
                completionBlock(nil, error)
            }
        })
    }
}
