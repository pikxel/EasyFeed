//
//  DashboardPostTableViewCell.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

class DashboardPostTableViewCell: CommonTableViewCell {
    // This really should not belong here, it mostly comes from the server
    // We have this array just for our feed to look nicer 
    private let images = ["avatar-female", "avatar-female1", "avatar-male-mask", "avatar-man"]

    private let postImage = UIImageView()
    private let stackView = UIStackView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let userNameLabel = UILabel()
    private let moreButton = UIButton()

    var isExpanded: Bool = false {
        didSet {
            bodyLabel.isHidden = !isExpanded
        }
    }

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
    }

    override func setupStyle() {
        super.setupStyle()

        selectionStyle = .none

        titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0

        titleLabel.font = UIFont.systemFont(ofSize: 16)
        bodyLabel.font = UIFont.systemFont(ofSize: 12)

        stackView.axis = .vertical
        stackView.spacing = Constants.UI.margin / 2
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        containerView.backgroundColor = UIColor.white
        containerView.roundedWithShadow()
        backgroundColor = Constants.Color.blue

        postImage.layer.cornerRadius = 15
        postImage.image = UIImage(named: "avatar-man")

        // TODO replace this
        userNameLabel.text = "User"
        postImage.image = UIImage(named: images.randomElement() ?? "")

        moreButton.setTitle("See more", for: .normal)
        moreButton.setTitleColor(UIColor.black, for: .normal)
        moreButton.backgroundColor = UIColor(red: 0.79, green: 0.54, blue: 0.07, alpha: 1.00)
        moreButton.layer.cornerRadius = 7
    }

    func setupFrom(post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }

    override func prepareForReuse() {
        isExpanded = false
    }
}
