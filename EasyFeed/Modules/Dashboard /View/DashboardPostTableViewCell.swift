//
//  DashboardPostTableViewCell.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

class DashboardPostTableViewCell: CommonTableViewCell {
    // MARK: - UI elements
    private let postImage: UIImageView = {
        let imagView = UIImageView()
        imagView.layer.cornerRadius = 15
        return imagView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.UI.margin / 2
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.white
        view.roundedWithShadow()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("See more", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = Constants.Color.pink
        button.layer.cornerRadius = 7
        return button
    }()

    // MARK: - Stored properties
    var isExpanded: Bool = false {
        didSet {
            bodyLabel.isHidden = !isExpanded
        }
    }
    var seeMoreClicked: (() -> Void)?

    // MARK: - Lifecycle
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(containerView)
        containerView.addSubviews(stackView, postImage, userNameLabel, moreButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
    }

    override func setupLayout() {
        super.setupLayout()
        containerView.pinHorizontalSides(toSidesOfView: contentView, padding: Constants.UI.margin)
        containerView.pinVerticalSides(toSidesOfView: contentView, padding: Constants.UI.margin)

        postImage.pinLeadingToContainer(padding: Constants.UI.margin)
        postImage.pinTopToContainer(padding: Constants.UI.margin)
        postImage.widthAnchor(equalTo: Constants.UI.screenWidth * 0.1)
        postImage.heightAnchor(equalTo: Constants.UI.screenWidth * 0.1)

        userNameLabel.centerVerticaly(with: postImage)
        userNameLabel.leadingAnchor(equalTo: postImage.trailingAnchor, padding: Constants.UI.margin)
        userNameLabel.trailingAnchor(lessThanOrEqualTo: moreButton.trailingAnchor, padding: Constants.UI.margin)

        moreButton.centerVerticaly(with: postImage)
        moreButton.widthAnchor(equalTo: Constants.UI.screenWidth * 0.22)
        moreButton.trailingAnchor(equalTo: containerView.trailingAnchor, padding: Constants.UI.margin / 2)

        stackView.pinHorizontalSides(toSidesOfView: containerView, padding: Constants.UI.margin)
        stackView.topAnchor(equalTo: postImage.bottomAnchor, padding: Constants.UI.margin)
        stackView.pinBottomToContainer(padding: Constants.UI.margin)

        moreButton.addTarget(self, action: #selector(moreClicked), for: .touchUpInside)
    }

    override func setupStyle() {
        super.setupStyle()
        selectionStyle = .none
        backgroundColor = Constants.Color.blue
    }

    override func prepareForReuse() {
        isExpanded = false
    }

    func setupFrom(post: UserPost) {
        userNameLabel.text = post.user?.name
        titleLabel.text = post.post.title
        bodyLabel.text = post.post.body
        postImage.image = UIImage(named: post.user?.image ?? "")
    }

    // MARK: - Actions
    @objc private func moreClicked() {
        seeMoreClicked?()
    }
}
