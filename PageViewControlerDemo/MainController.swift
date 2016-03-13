//
//  MainController.swift
//  PageViewControlerDemo
//
//  Created by min-mac on 16/3/12.
//  Copyright © 2016年 EgeTart. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    var pageViewController: UIPageViewController!
    
    @IBOutlet var sliderView: UIView!
    
    var movieController: MovieController!
    var musicController: MusicController!
    var bookController: BookController!
    var controllers = [UIViewController]()
    
    var sliderImageView: UIImageView!
    
    var lastPage = 0
    var currentPage: Int = 0 {
        didSet {
            //根据当前页面计算得到便宜量
            //一个微小的动画移动提示条
            let offset = self.view.frame.width / 3.0 * CGFloat(currentPage)
            UIView.animateWithDuration(0.3) { () -> Void in
                self.sliderImageView.frame.origin = CGPoint(x: offset, y: -1)
            }
            
            //根据currentPage 和 lastPage的大小关系，控制页面的切换方向
            if currentPage > lastPage {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .Forward, animated: true, completion: nil)
            }
            else {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .Reverse, animated: true, completion: nil)
            }
            
            lastPage = currentPage
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //获取到嵌入的UIPageViewController
        pageViewController = self.childViewControllers.first as! UIPageViewController
        
        //根据Storyboard ID来创建一个View Controller
        movieController = storyboard?.instantiateViewControllerWithIdentifier("MovieControllerID") as! MovieController
        musicController = storyboard?.instantiateViewControllerWithIdentifier("MusicControllerID") as! MusicController
        bookController = storyboard?.instantiateViewControllerWithIdentifier("BookControllerID") as! BookController
        
        //设置pageViewController的数据源代理为当前Controller
        pageViewController.dataSource = self
        
        //手动为pageViewController提供提一个页面
        pageViewController.setViewControllers([movieController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        //添加提示条到页面中
        sliderImageView = UIImageView(frame: CGRect(x: 0, y: -1, width: self.view.frame.width / 3.0, height: 3.0))
        sliderImageView.image = UIImage(named: "slider")
        sliderView.addSubview(sliderImageView)
        
        //把页面添加到数组中
        controllers.append(movieController)
        controllers.append(musicController)
        controllers.append(bookController)
        
        //接收页面改变的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "currentPageChanged:", name: "currentPageChanged", object: nil)

    }
    
    @IBAction func changeCurrentPage(sender: UIButton) {
        //button的tag分别为100，101，102，减去100之后就对应页面的索引
        currentPage = sender.tag - 100
    }
    
    //通知响应方法
    func currentPageChanged(notification: NSNotification) {
        currentPage = notification.object as! Int
    }
}

extension MainController: UIPageViewControllerDataSource {
    
    //返回当前页面的下一个页面
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKindOfClass(MovieController) {
            return musicController
        }
        else if viewController.isKindOfClass(MusicController) {
            return bookController
        }
        return nil
        
    }
    
    //返回当前页面的上一个页面
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKindOfClass(MusicController) {
            return movieController
        }
        else if viewController.isKindOfClass(BookController) {
            return musicController
        }
        return nil
    }
}

