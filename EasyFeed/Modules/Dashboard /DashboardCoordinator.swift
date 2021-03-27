//
//  DashboardCoordinator.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation
import UIKit

class DashboardCoordinator: Coordinator {
    var parentCoordinator: Coordinator?

    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController?

    var rootViewController: CommonViewController?

    init(rootViewController: CommonViewController?, parentCoordinator: Coordinator) {
        self.rootViewController = rootViewController
        self.parentCoordinator = parentCoordinator
        self.navigationController = rootViewController?.navigationController
    }

    func start() {
        let viewController = DashboardViewController(coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func startPostDetailCoordinator(userPost: UserPost) {
        let postCoordinator = PostDetailCoordinator(userPost: userPost, rootViewController: nil, parentCoordinator: self)
        postCoordinator.navigationController = navigationController
        childCoordinators.append(postCoordinator)
        postCoordinator.start()
    }

    func finnish() {
        // Handle this
    }
}
