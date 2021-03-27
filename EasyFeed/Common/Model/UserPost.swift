//
//  UserPost.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation

// MARK: - UserPost
struct UserPost {
    var post: Post
    var user: User?
    var comments: [Comment]
}
