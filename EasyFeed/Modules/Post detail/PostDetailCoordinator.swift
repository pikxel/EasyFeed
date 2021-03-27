//
//  PostDetailCoordinator.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation
import UIKit

class PostDetailCoordinator: Coordinator {
    var parentCoordinator: Coordinator?

    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController?

    var rootViewController: CommonViewController?

    var userPost: UserPost

    init(userPost: UserPost, rootViewController: CommonViewController?, parentCoordinator: Coordinator) {
        self.rootViewController = rootViewController
        self.parentCoordinator = parentCoordinator
        self.userPost = userPost
    }

    func start() {
        let viewController = PostDetailViewController(userPost: userPost, coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func finnish() {

    }
}
