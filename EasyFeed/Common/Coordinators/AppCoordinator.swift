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
        let rootViewController = DashboardViewController(coordinator: self)
        self.window.rootViewController = rootViewController
    }
}
