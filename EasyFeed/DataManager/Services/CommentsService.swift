//
//  CommentsService.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation

class CommentsService {
    private let dashboardPath = "comments"

    func fetchComments(completionBlock: @escaping ([Comment]?, String?) -> Void) {
        let endPoint = EndPoint<[Comment]>(urlParameter: nil,
                                         expectedResponseType: [Comment].self,
                                         expectedResponseCode: 200,
                                         path: dashboardPath,
                                         api: .weather)
        APIService().perform(endPoint: endPoint, completion: { success, data, error  in
            if success {
                completionBlock(data, nil)
            } else {
                if error?.code == 404 {
                    completionBlock(nil, "Somethng when wrong when fetching the users")
                } else {
                    completionBlock(nil, error?.description)
                }
            }
        })
    }
}

