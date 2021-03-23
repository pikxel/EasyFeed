//
//  DashboardViewController.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import UIKit

class DashboardViewController: CommonTableViewController {
    private let dashboardService = DashboardService()
    private var posts: [Post] = []
    private var expandedRows: [Int] = []

    // TODO - Ha elmegy aludni Fanni, atcsinalni
    private let headerView: UIView = {
        let result = UIView()
        let label = UILabel()
        result.addSubview(label)
        label.text = "My EasyFeed"
        label.textAlignment = .center
        label.pinHorizontalSides(toSidesOfView: result, padding: Constants.UI.margin)
        label.pinVerticalSides(toSidesOfView: result, padding: Constants.UI.margin)
        result.backgroundColor = UIColor.white
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.setTableHeaderView(headerView: headerView)
    }

    // MARK: - Networking
    private func loadData() {
        dashboardService.fetchPosts { [weak self] (posts, error)  in
            self?.posts = posts ?? []
            self?.reloadTableView()
        }
    }
}

extension DashboardViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DashboardPostTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.setupFrom(post: posts[indexPath.row])
        cell.isExpanded = expandedRows.contains(indexPath.row)
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
