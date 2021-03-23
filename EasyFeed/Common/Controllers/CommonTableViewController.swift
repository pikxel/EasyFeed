//
//  CommonTableViewController.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

class CommonTableViewController: CommonViewController {
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupLayout() {
        super.setupLayout()

        tableView.pinHorizontalSides(toSidesOfView: view)
        tableView.pinVerticalSides(toSidesOfView: view)
    }

    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(tableView)
    }

    override func setupStyle() {
        super.setupStyle()
        tableView.backgroundColor = Constants.Color.blue
        tableView.separatorStyle = .none
    }

    // Reloads the tableView on the main thread
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CommonTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
