//
//  DashboardViewController.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import UIKit

class DashboardViewController: CommonTableViewController {
    private let dashboardService = DashboardService()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Networking
    private func loadData() {
        dashboardService.fetchPosts { [weak self] (posts, error)  in
            print(posts)
        }
    }
}

class CommonTableViewController: CommonViewController {
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }

    private func layout() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension CommonTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


import UIKit
import Foundation
class ProgressIndicator: UIView {

var indicatorColor:UIColor
var loadingViewColor:UIColor
var loadingMessage:String
var messageFrame = UIView()
var activityIndicator = UIActivityIndicatorView()

init(inview:UIView,loadingViewColor:UIColor,indicatorColor:UIColor,msg:String){

    self.indicatorColor = indicatorColor
    self.loadingViewColor = loadingViewColor
    self.loadingMessage = msg
    super.init(frame: CGRect(x: inview.frame.midX - 90, y: inview.frame.midY - 250 , width: 180, height: 50))
    initalizeCustomIndicator()

}
convenience init(inview:UIView) {

    self.init(inview: inview,loadingViewColor: UIColor.brown,indicatorColor:UIColor.black, msg: "Loading..")
}
convenience init(inview:UIView,messsage:String) {

    self.init(inview: inview,loadingViewColor: UIColor.brown,indicatorColor:UIColor.black, msg: messsage)
}

required init?(coder aDecoder: NSCoder) {

    fatalError("init(coder:) has not been implemented")
}

func initalizeCustomIndicator(){

    messageFrame.frame = self.bounds
    activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    activityIndicator.tintColor = indicatorColor
    activityIndicator.hidesWhenStopped = true
    activityIndicator.frame = CGRect(x: self.bounds.origin.x + 6, y: 0, width: 20, height: 50)
    print(activityIndicator.frame)
    let strLabel = UILabel(frame:CGRect(x: self.bounds.origin.x + 30, y: 0, width: self.bounds.width - (self.bounds.origin.x + 30) , height: 50))
    strLabel.text = loadingMessage
    strLabel.adjustsFontSizeToFitWidth = true
    strLabel.textColor = UIColor.white
    messageFrame.layer.cornerRadius = 15
    messageFrame.backgroundColor = loadingViewColor
    messageFrame.alpha = 0.8
    messageFrame.addSubview(activityIndicator)
    messageFrame.addSubview(strLabel)


}

func  start(){
    //check if view is already there or not..if again started
    if !self.subviews.contains(messageFrame){

        activityIndicator.startAnimating()
        self.addSubview(messageFrame)

    }
}

func stop(){

    if self.subviews.contains(messageFrame){

        activityIndicator.stopAnimating()
        messageFrame.removeFromSuperview()

    }
}
}
