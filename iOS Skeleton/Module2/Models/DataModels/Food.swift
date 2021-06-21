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
