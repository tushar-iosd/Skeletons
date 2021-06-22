//
//  Food.swift
//  iOS Skeleton
//
//  Created by Tushar Sharma on 21/06/21.
//

import UIKit

struct Food {
    var name: String
    var imageName: String
    var favItem: Bool
    
    init(name: String, imageName: String, favItem: Bool) {
        self.name = name
        self.imageName = imageName
        self.favItem = favItem
    }
}


struct Comments: Codable {
    var body: String
    var email: String
    var id: Int
    var name: String
    var postId: Int
    private enum CodingKeys: String, CodingKey{
        case body = "body"
        case email = "email"
        case id = "id"
        case name = "name"
        case postId = "postId"
    }
}
