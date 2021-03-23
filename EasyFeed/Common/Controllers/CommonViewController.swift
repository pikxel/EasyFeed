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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupLayout()
        setupStyle()
    }

    // Place here all the subview setups related to this ViewController
    // To be overriden by sub-ViewController
    func setupSubviews() {
        // To be overriden
    }

    // Place here all the constraints realted to this ViewController
    // To be overriden by sub-ViewController
    func setupLayout() {
        // To be overriden
    }

    // Place here all the style related setup
    // To be overriden by sub-ViewController
    func setupStyle() {
        // To be overriden
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
