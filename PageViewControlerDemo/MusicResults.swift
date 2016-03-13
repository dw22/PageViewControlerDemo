//
//  MusicResults.swift
//  PageViewControlerDemo
//
//  Created by min-mac on 16/3/13.
//  Copyright © 2016年 EgeTart. All rights reserved.
//

import Foundation

class MusicResults {
    var musics = [CommonDataModel]()
    
    init(dicts: [NSDictionary]) {
        
        for dict in dicts {
            let imageURL = dict["image"] as! String
            let title = dict["title"] as! String
            
            let music = CommonDataModel(imageURL: imageURL, title: title)
            musics.append(music)
        }
    }
}