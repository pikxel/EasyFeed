//
//  PostsService.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation

class PostsService: NetowrkService<[Post]> {
    private let dashboardPath = "posts"

    override func loadData(completionBlock: @escaping ([Post]?, Error?) -> Void) {
        let endPoint = EndPoint<[Post]>(urlParameter: nil,
                                         expectedResponseType: [Post].self,
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
