//
//  MovieResults.swift
//  PageViewControlerDemo
//
//  Created by min-mac on 16/3/13.
//  Copyright © 2016年 EgeTart. All rights reserved.
//

import Foundation

class MovieResults {
    
    //存储电影信息的数组
    var movies = [CommonDataModel]()
    
    init(dicts: [NSDictionary]) {
        
        //遍历字典数组，拿到图像地址，标题信息
        //接着使用CommonDataModel创建一条电影记录
        for dict in dicts {
            let imageURL = (dict["images"] as! NSDictionary)["large"] as! String
            let title = dict["title"] as! String
            
            let movie = CommonDataModel(imageURL: imageURL, title: title)
            movies.append(movie)
        }
    }
}