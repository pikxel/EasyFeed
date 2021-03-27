//
//  UserService.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation

class UsersService: NetowrkService<[User]> {
    private let dashboardPath = "users"

    override func loadData(completionBlock: @escaping ([User]?, Error?) -> Void) {
        let endPoint = EndPoint<[User]>(urlParameter: nil,
                                         expectedResponseType: [User].self,
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
