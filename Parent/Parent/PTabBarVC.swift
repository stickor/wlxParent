//
//  PTabBarVC.swift
//  Parent
//
//  Created by osnail on 2017/8/1.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit

class PTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(childController: PCourseVC(),title:"课程",imageName:"tabBar_course")
        addChildViewController(childController: PGradeVC(),title:"班级",imageName: "tabBar_class")
        addChildViewController(childController: PMessageCenterVC(),title: "消息",imageName: "tabBar_news")
        addChildViewController(childController: PMeVC(), title: "我", imageName: "tabBar_me")
    }
    func addChildViewController(childController: UIViewController,title:String,imageName:String) {
        
        childController.title = title;
//        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_h")
        
        tabBar.tintColor = UIColor.orange
        
        let nav = UINavigationController()
        nav.navigationBar.barTintColor = UIColor.init(hex: "fdd000")
        nav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
        nav.addChildViewController(childController)
        
        self.addChildViewController(nav)
        
    }

}
