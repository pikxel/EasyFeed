//
//  DashboardViewController.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import UIKit

class DashboardViewController: CommonTableViewController {
    private var expandedRows: [Int] = []
    private let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Easy feed"
        loadData()
    }

    // MARK: - Networking
    private func loadData() {
        dataManager.loadData { [weak self] success in
            if !success {
                self?.presentAlert(title: "Something went wrong",
                                   message: "An error occured when loading the data",
                                   options: "Try again", completion: { _ in
                    // Weak self already captured
                    self?.loadData()
                })
            }
            self?.reloadTableView()
        }
    }
}

extension DashboardViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManager.userPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DashboardPostTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.setupFrom(post: dataManager.userPosts[indexPath.row])
        cell.isExpanded = expandedRows.contains(indexPath.row)
        cell.seeMoreClicked = { [weak self] in
            guard let self = self else { return }
            if let dashboardCoordinator = self.coordinator as? DashboardCoordinator {
                dashboardCoordinator.startPostDetailCoordinator(userPost: self.dataManager.userPosts[indexPath.row])
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = expandedRows.firstIndex(of: indexPath.row) {
            expandedRows.remove(at: index)
        } else {
            expandedRows.append(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
