//
//  Product.swift
//  Product Project UIKit
//
//  Created by İdil Toprakkale on 21.01.2025.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable {
    let productId: String
    let name: String
    let price: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name
        case price
        case image
    }
}
