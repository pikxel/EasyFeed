//
//  Comment.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation

// MARK: - Comment
struct Comment: Codable {
    let postID, commentID: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case commentID = "id"
        case name, email, body
    }
}
