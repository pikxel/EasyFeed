//
//  DashboardService.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation

class DashboardService {
    private let dashboardPath = "posts"

    func fetchPosts(completionBlock: @escaping ([Post]?, String?) -> Void) {
        let endPoint = EndPoint<[Post]>(urlParameter: nil,
                                         expectedResponseType: [Post].self,
                                         expectedResponseCode: 200,
                                         path: dashboardPath,
                                         api: .weather)
        APIService().perform(endPoint: endPoint, completion: { success, data, error  in
            if success {
                completionBlock(data, nil)
            } else {
                if error?.code == 404 {
                    completionBlock(nil, "Somethng when wrong when fetching the dashboard posts")
                } else {
                    completionBlock(nil, error?.description)
                }
            }
        })
    }
}

struct Post: Codable {
    let userID, postID: Int
    let body, title: String

    private enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case postID = "id"
        case body
        case title
    }
}
