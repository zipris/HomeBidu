//
//  FeedProductModel.swift
//  HomeBidu
//
//  Created by Lê Kim Hoàng on 2/11/22.
//

import UIKit

struct FeedProductModel: Codable {
    let productId: String
    let productName: String
    let positionX: Float
    let positionY: Float
    let order: Int
}
