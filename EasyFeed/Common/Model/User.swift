//
//  User.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation

// MARK: - User
struct User: Codable {
    let userID: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    var image: String? // Just a local property to show random image for the user 

    private enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name, username, email, address, phone, website, company, image
    }
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase: String
}
