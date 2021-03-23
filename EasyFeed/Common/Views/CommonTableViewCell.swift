//
//  CommonTableViewCell.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

class CommonTableViewCell: UITableViewCell {
    static var Identifier: String {
         return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    func initialize() {
        setupSubviews()
        setupLayout()
        setupStyle()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
        // Initialization code
    }

    // Place here all the subview setups related to this View
    // To be overriden by super class
    func setupSubviews() {
        // To be overriden
    }

    // Place here all the constraints realted to this View
    // To be overriden by super class
    func setupLayout() {
        // To be overriden
    }

    // Place here all the style related setup
    // To be overriden by super class
    func setupStyle() {
        // To be overriden
    }
}
