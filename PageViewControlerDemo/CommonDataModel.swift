//
//  CommonDataModel.swift
//  PageViewControlerDemo
//
//  Created by min-mac on 16/3/13.
//  Copyright © 2016年 EgeTart. All rights reserved.
//

import Foundation

/**
 *  基本数据模型, 包含图像地址和标题
 */
struct CommonDataModel {
    var imageURL: String!
    var title: String
    
    init(imageURL: String, title: String) {
        self.imageURL = imageURL
        self.title = title
    }
}