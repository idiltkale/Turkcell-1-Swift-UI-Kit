//
//  ProductDetail.swift
//  Product Project UIKit
//
//  Created by İdil Toprakkale on 23.01.2025.
//

import Foundation

struct ProductDetail: Codable {
    let productId: String
    let name: String
    let price: Int
    let image: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name
        case price
        case image
        case description
    }
}
