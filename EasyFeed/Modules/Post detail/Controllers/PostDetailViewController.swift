//
//  PostDetailViewController.swift
//  EasyFeed
//
//  Created by Peter Lizak on 26/03/2021.
//

import Foundation
import UIKit

// Maybe this controller's base view should be a SrollView, so when we have a long post, the user is able to scroll
class PostDetailViewController: CommonViewController {
    // MARK: - UI components
    private let imageView = UIImageView()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let commentsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Comments"
        label.textAlignment = .center
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private let userPost: UserPost

    init(userPost: UserPost, coordinator: Coordinator?) {
        self.userPost = userPost
        super.init(coordinator: coordinator)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        title = "Post detail"
    }

    private func setupContent() {
        nameLabel.text = userPost.user?.name
        descriptionLabel.text = userPost.post.body
        imageView.image = UIImage(named: userPost.user?.image ?? "")
    }

    override func setupStyle() {
        super.setupStyle()
        view.backgroundColor = .white
    }

    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(commentsTitle)
        view.addSubview(tableView)
    }

    override func setupLayout() {
        super.setupLayout()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor, padding: Constants.UI.margin * 2)
        imageView.centerHorizontaly(with: view)
        imageView.widthAnchor(equalTo: Constants.UI.screenWidth * 0.4)
        imageView.heightAnchor(equalTo: imageView.widthAnchor)

        nameLabel.topAnchor(equalTo: imageView.bottomAnchor, padding: Constants.UI.margin)
        nameLabel.pinHorizontalSides(toSidesOfView: view)

        descriptionLabel.pinTop(toBottomOfView: nameLabel, padding: Constants.UI.margin)
        descriptionLabel.pinHorizontalSides(toSidesOfView: view, padding: Constants.UI.margin)

        commentsTitle.pinTop(toBottomOfView: descriptionLabel, padding: Constants.UI.margin * 2)
        commentsTitle.pinHorizontalSides(toSidesOfView: view)

        tableView.pinTop(toBottomOfView: commentsTitle, padding: Constants.UI.margin)
        tableView.pinHorizontalSides(toSidesOfView: view)
        tableView.pinBottomToContainer()
    }
}

extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPost.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.setupFrom(comment: userPost.comments[indexPath.row])
        return cell
    }
}
