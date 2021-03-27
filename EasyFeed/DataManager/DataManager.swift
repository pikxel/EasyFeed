//
//  DataManager.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation

/* I prefered not to use singleton pattern here. Singleton classes can grow large.
   Also when you have a big application with a signelton data manager, at some point you just loose track
   Which class is manipulating with the data */
class DataManager {
    // Just giving the user a random image for our post feed to look nicer
    // Usualy this kind of code should not be present here
    private let avatarImages = ["avatar-female", "avatar-female1", "avatar-male-mask", "avatar-man"]

    var userPosts: [UserPost] = []

    // Loads the User, Post and Comments objects
    // Be default it will load and cache the Users and Posts and Comments requests
    // NOTE: Maybe the comments request should not be called only if we navigate to the PostDetail screen
    func loadData(completion: @escaping (Bool) -> Void) {
        postsLoaded = false
        usersLoaded = false

        loadPosts { [weak self] result in
            self?.postsLoaded = true
            if self?.usersLoaded ?? false && self?.commentsLoaded ?? false {
                self?.updateUserPosts()
                completion(result)
            }
        }

        loadUsers { [weak self] result in
            self?.usersLoaded = true
            if self?.postsLoaded ?? false && self?.commentsLoaded ?? false {
                self?.updateUserPosts()
                completion(result)
            }
        }

        loadComments { [weak self] result in
            self?.commentsLoaded = true
            if self?.postsLoaded ?? false && self?.usersLoaded ?? false {
                self?.updateUserPosts()
                completion(result)
            }
        }
    }

    // Will pair and combine the fetched data into logical objects
    // NOTE: This type of work really should be done by the backend
    private func updateUserPosts() {
        userPosts = []
        for post in posts {
            var user = users.first {$0.userID == post.userID }
            user?.image = avatarImages.randomElement()
            let comment = comments.filter {$0.postID == post.postID }
            let userPost = UserPost(post: post, user: user, comments: comment)
            userPosts.append(userPost)
        }
    }

    // MARK: - Post
    private var postsLoaded = false
    private var posts: [Post] = []
    private let postsService = PostsService()
    private func loadPosts(completion: @escaping (Bool) -> Void) {
        guard !postsLoaded else {
            // If we already have the posts do not fetch it again
            completion(true)
            return
        }

        postsService.fetchPosts { [weak self] (posts, error) in
            if error == nil {
                self?.posts = posts ?? []
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    // MARK: - User
    private var usersLoaded = false
    private var users: [User] = []
    private let userService = UsersService()
    private func loadUsers(completion: @escaping (Bool) -> Void) {
        guard !usersLoaded else {
            // If we already have the users do not fetch them again
            completion(true)
            return
        }

        userService.fetchUsers { [weak self] (users, error) in
            if error == nil {
                self?.users = users ?? []
                completion(true)
            } else {
                self?.users = []
            }
        }
    }

    // MARK: - Comment
    private var commentsLoaded = false
    private var comments: [Comment] = []
    private let commentsService = CommentsService()
    private func loadComments(completion: @escaping (Bool) -> Void) {
        guard !commentsLoaded else {
            // If we already have the comments do not fetch them again
            completion(true)
            return
        }

        commentsService.fetchComments { [weak self] (comments, error) in
            if error == nil {
                self?.comments = comments ?? []
                completion(true)
            } else {
                self?.users = []
            }
        }
    }
}
