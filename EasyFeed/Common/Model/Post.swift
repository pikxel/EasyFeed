//
//  Post.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let userID, postID: Int
    let body, title: String

    private enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case postID = "id"
        case body, title
    }
}
