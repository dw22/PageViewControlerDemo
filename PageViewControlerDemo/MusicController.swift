//
//  MusicController.swift
//  PageViewControlerDemo
//
//  Created by min-mac on 16/3/12.
//  Copyright © 2016年 EgeTart. All rights reserved.
//

import UIKit

class MusicController: UIViewController {
    
    @IBOutlet var musicTableView: UITableView!
    
    var musicResults: MusicResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicTableView.registerNib(UINib(nibName: "CommonCell", bundle: nil), forCellReuseIdentifier: "CommonCell")
        musicTableView.dataSource = self
        musicTableView.delegate = self
        
        GetDataFromDouBan.getData("https://api.douban.com/v2/music/search", type: "musics", keyword: "梁静茹") { (data) -> Void in
            self.musicResults = MusicResults(dicts: data)
            self.musicTableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //发送一个名字为currentPageChanged，附带object的值代表当前页面的索引
        NSNotificationCenter.defaultCenter().postNotificationName("currentPageChanged", object: 1)
    }
    
}

extension MusicController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let result = musicResults {
            return result.musics.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let music = musicResults!.musics[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CommonCell", forIndexPath: indexPath) as! CommonCell
        cell.coverImageView.sd_setImageWithURL(NSURL(string: music.imageURL))
        cell.titleLabel.text = music.title
        
        return cell
    }
}

extension MusicController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

