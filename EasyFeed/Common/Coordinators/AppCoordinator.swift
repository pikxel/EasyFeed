//
//  AppCoordinator.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        startDashboardCoordinator()
    }

    func startDashboardCoordinator() {
        let dashboardCoordinator = DashboardCoordinator(rootViewController: nil, parentCoordinator: self)
        let rootViewController = DashboardViewController(coordinator: dashboardCoordinator)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        dashboardCoordinator.navigationController = navigationController
        self.window.rootViewController = navigationController
    }
}
