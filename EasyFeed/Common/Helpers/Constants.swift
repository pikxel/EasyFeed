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
        static let blue = UIColor(red: 0.45, green: 0.63, blue: 0.91, alpha: 1.00)
        static let white = UIColor.white
        static let pink = UIColor(red: 0.91, green: 0.45, blue: 0.63, alpha: 1.00)
    }
}
