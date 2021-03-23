//
//  UITableView+Extension.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {}

extension UITableView {
    private func register<T: UITableViewCell>(_ cell: T.Type) {
        register(cell.self, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    // Deques a UITableViewCell subclass from the TableView
    // If the class was not registered previously, it is done also
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        register(T.self)
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cannot dequeue cell of type \(T.self)")
        }
        return cell
    }

    /// Set table header view & add Auto layout.
    func setTableHeaderView(headerView: UIView) {
        let headerContainerView = UIView()
        headerContainerView.backgroundColor = .clear
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.addSubview(headerView)
        headerView.pinSides(toSidesofView: headerContainerView)

        // Set first.
        self.tableHeaderView = headerContainerView

        // Then setup AutoLayout.
        headerContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerContainerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        updateHeaderViewFrame()
    }

    /// Update header view's frame.
    func updateHeaderViewFrame() {
        guard let headerView = self.tableHeaderView else { return }

        // Update the size of the header based on its internal content.
        headerView.layoutIfNeeded()

        // ***Trigger table view to know that header should be updated.
        let header = self.tableHeaderView
        self.tableHeaderView = header
    }
}
