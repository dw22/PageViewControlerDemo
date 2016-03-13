//
//  MovieController.swift
//  PageViewControlerDemo
//
//  Created by min-mac on 16/3/12.
//  Copyright © 2016年 EgeTart. All rights reserved.
//

import UIKit
import SDWebImage

class MovieController: UIViewController {
    
    @IBOutlet var movieTableView: UITableView!
    
    var movieResults: MovieResults?

    override func viewDidLoad() {
        super.viewDidLoad()

        movieTableView.registerNib(UINib(nibName: "CommonCell", bundle: nil), forCellReuseIdentifier: "CommonCell")
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        GetDataFromDouBan.getData("https://api.douban.com/v2/movie/search", type: "subjects", keyword: "张艺谋") { (data) -> Void in
            self.movieResults = MovieResults(dicts: data)
            self.movieTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //发送一个名字为currentPageChanged，附带object的值代表当前页面的索引
        NSNotificationCenter.defaultCenter().postNotificationName("currentPageChanged", object: 0)
    }

}

//MARK: - UITableViewDataSource
extension MovieController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let result = movieResults {
            return result.movies.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movie = movieResults!.movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CommonCell", forIndexPath: indexPath) as! CommonCell
        cell.coverImageView.sd_setImageWithURL(NSURL(string: movie.imageURL))
        cell.titleLabel.text = movie.title
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MovieController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
