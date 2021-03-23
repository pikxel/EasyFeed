//
//  CommonViewController.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

class CommonViewController: UIViewController {
    var coordinator: Coordinator?

    // MARK: - Initialization
    public init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
