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
    var messageData = JSON.init(AnyClass.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息中心"
        self.tabBarItem.title = "消息"
        
        tableView.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
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
        
        let request:PRequestManager = PRequestManager()
        let dic = ["pageStart":"1","pageSize":"20"]
        let data =  request.request(type: "GET", urlString: "/client/family/messages", parameters: dic as NSDictionary)
        messageData = data
        
        if messageData["code"].intValue == 0 {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:PMessageCenterCell = tableView.dequeueReusableCell(withIdentifier: messageCell, for: indexPath as IndexPath) as! PMessageCenterCell

        if !(cell.isEqual(nil)) {
            cell = PMessageCenterCell.init(style:UITableViewCellStyle.default, reuseIdentifier:messageCell)
            
        }
        let dic = ["title":"11111","content":"222222222222","time":"2017-01-01"]
            cell.updateWithData(data: dic as NSDictionary)

        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
