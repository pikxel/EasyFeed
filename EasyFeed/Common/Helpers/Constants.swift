//
//  Constants.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

enum Constants {
    enum UI {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let margin: CGFloat = screenWidth * 0.044
        static let cornerRadius: CGFloat = 6
        static let buttonBorderWidth: CGFloat = 1
    }

    enum Color {
        static let blue = UIColor(red: 0.07, green: 0.69, blue: 0.91, alpha: 1.00)
    }
}
