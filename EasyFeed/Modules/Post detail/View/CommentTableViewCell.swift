//
//  CommentTableViewCell.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation
import UIKit

class CommentTableViewCell: CommonTableViewCell {
    // MARK: - UI elements
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Color.blue
        view.roundedWithShadow()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Lifecycle
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(bodyLabel)
    }

    override func setupLayout() {
        super.setupLayout()
        containerView.pinHorizontalSides(toSidesOfView: contentView, padding: Constants.UI.margin)
        containerView.pinVerticalSides(toSidesOfView: contentView, padding: Constants.UI.margin)

        titleLabel.pinTopToContainer(padding: Constants.UI.margin)
        titleLabel.pinHorizontalSides(toSidesOfView: containerView, padding: Constants.UI.margin)

        bodyLabel.pinTop(toBottomOfView: titleLabel, padding: Constants.UI.margin)
        bodyLabel.pinHorizontalSides(toSidesOfView: containerView, padding: Constants.UI.margin)
        bodyLabel.pinBottomToContainer(padding: Constants.UI.margin)
    }

    func setupFrom(comment: Comment) {
        bodyLabel.text = comment.body
        titleLabel.text = comment.name
    }
}
