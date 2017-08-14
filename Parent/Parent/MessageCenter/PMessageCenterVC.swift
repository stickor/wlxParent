//
//  PMessageCenterVC.swift
//  Parent
//
//  Created by osnail on 2017/8/1.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import SwiftyJSON

class PMessageCenterVC: PViewController,UITableViewDelegate,UITableViewDataSource{

    var tableView = UITableView ()
    var messageCell = "messageCell"
    var messageData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息中心"
        self.tabBarItem.title = "消息"
        
        tableView.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableView)
        
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh(page:)))
        tableView.mj_header = header

        tableView.register(PMessageCenterCell.self, forCellReuseIdentifier: messageCell)
    }
    func headerRefresh(page:NSInteger) {
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.mj_header.endRefreshing()
        }
        self.getData()
        
        
    }
    
    func getData() {
        
        let request:RequestManager = RequestManager()
        let dic = ["pageStart":"0","pageSize":"20"]
        let urlRequest =  request.request(type: "GET", urlString: "/client/family/messages", parameters: dic as NSDictionary)
        
        Alamofire.request(urlRequest).responseJSON { response in
            
            if response.result.isSuccess{
                let json = JSON(data: response.data!)
                print("请求返回的code==:\(json["code"])")
                if json["code"].intValue == 0 {
                    let dic = json["data"].rawValue
                    self.messageData = dic as! NSDictionary
                    self.tableView.reloadData()
                }
                
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
//            if let jsonValue = response.result.value {
//                print(jsonValue)
//            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let existence = self.messageData["content"]
        if ((existence) != nil) {
            let arr = self.messageData["content"] as!NSArray
            return arr.count
        }else{
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:PMessageCenterCell = tableView.dequeueReusableCell(withIdentifier: messageCell, for: indexPath as IndexPath) as! PMessageCenterCell

        if !(cell.isEqual(nil)) {
            cell = PMessageCenterCell.init(style:UITableViewCellStyle.default, reuseIdentifier:messageCell)
            
        }
        let arr = self.messageData["content"] as!NSArray
        let dic = arr[indexPath.row]
        cell.updateWithData(data: dic as! NSDictionary)

        cell.blo = { str in
            print("test block---\(str)")

        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
}
