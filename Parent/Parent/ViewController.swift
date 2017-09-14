//
//  ViewController.swift
//  Parent
//
//  Created by osnail on 2017/7/26.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import BFKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var imageShow: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     self.imageShow.sd_setImage(with: URL(string: "http://static-wlx.oss-cn-beijing.aliyuncs.com/189c14c5-3fd3-45ad-8e20-e0d67d6d27f6.jpeg" as String ), placeholderImage: #imageLiteral(resourceName: "zweiSquare"))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

