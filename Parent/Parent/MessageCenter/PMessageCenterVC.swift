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
import ObjectMapper
import MobilePlayer
import MobilePlayer
import SKPhotoBrowser

class PMessageCenterVC: PViewController,UITableViewDelegate,UITableViewDataSource{

    var tableView = UITableView ()
    var messageCell = "messageCell"
    var messageData = NSDictionary()
    var jsonData = JSON.null
    var messageDataArray = NSMutableArray()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
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
        self.getData()

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
        let dic = ["pageStart":"0","pageSize":"60"]
        let urlRequest =  request.request(type: "GET", urlString: "/client/family/messages", parameters: dic as NSDictionary)
        
        Alamofire.request(urlRequest).responseJSON { response in
            
            if response.result.isSuccess{
                let json = JSON(data: response.data!)
                self.jsonData = JSON(data: response.data!)
                print("请求返回的code==:\(json["code"])")
                if json["code"].intValue == 0 {
                    let dic = json["data"].rawValue
                    print((json["data"]["content"].rawValue as AnyObject).count)
                    self.messageData = dic as! NSDictionary
                   
                    //////
                    let  messageModels = MessageDataModel(dicToModel:dic as! [String : Any])
                    
                    self.messageDataArray.addObjects(from: messageModels.content_list)
                    print("1234567890")
                     self.tableView.reloadData()
                    /////////////////
                    
//                    let dataArray = json["data"]["content"].arrayValue
                    
//                    for model in dataArray{
//                        let model4 = Mapper<PMessageMapModel>().map(JSON:model.rawValue as! [String : Any])
//                        self.messageDataArray.add(model4!)
//                    }
                    
//                    var contentJson = json["data"]["content"].arrayValue[0]
//                    
//                    let modell = Mapper<PMessageMapModel>().map(JSON: contentJson.rawValue as! [String : Any])
//                    let model2 = Mapper<PMessageMapModel>().map(JSON:self.jsonData["data"]["content"][0].rawValue as! [String : Any])
//                    var alldataJson = json["data"].arrayValue
                    
//                    let model3 = Mapper<PMessageMapModel>().mapArray(JSON: alldataJson)
                    
                    
//                    var model = PMessageCenterResModel(dicToModel:json.rawValue as! [String : Any])
//                    var model1 = MessageDataModel(dicToModel:json["data"].rawValue as! [String : Any])
//                    var modelArr = json["data"]["content"].rawValue as? [[String: Any]]
//
//                    print("\(model)\(model1)\(model2)")
//                    for model in modelArr! {
//                        
//                        self.messageDateModel.content.adding(PMessageCenterModel(dicToModel:model))
//
//                    }
//
//                }
                    
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
        return self.messageDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell:PMessageCenterCell = tableView.dequeueReusableCell(withIdentifier: messageCell, for: indexPath as IndexPath) as! PMessageCenterCell

        if !(cell.isEqual(nil)) {
            cell = PMessageCenterCell.init(style:UITableViewCellStyle.default, reuseIdentifier:messageCell)
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.updateWithData(data: self.messageDataArray[indexPath.row] as! PMessageCenterModel)

        cell.playVideoBlock = { str in
            print("111111111"+str)
            
            let playerVC = MobilePlayerViewController(contentURL: URL(string:str)!)
            playerVC.title = "Vanilla Player - \(str)"
            playerVC.activityItems = [URL(string:str)!]
            self.navigationController?.navigationBar.isHidden = true
            playerVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(playerVC, animated: true)
        }
        cell.showImageDetailBlock = { index,urls,imageViews in
            print("2222222"+"\(index)"+"\(urls)"+"\(imageViews)")
            
            SKPhotoBrowserOptions.enableZoomBlackArea    = true
            SKPhotoBrowserOptions.enableSingleTapDismiss = true
            SKPhotoBrowserOptions.bounceAnimation =  true
            SKPhotoBrowserOptions.displayAction = false
            let browser = SKPhotoBrowser(photos: self.createLocalPhotos(urls:urls))
            browser.initializePageIndex(index)
            browser.delegate = self as? SKPhotoBrowserDelegate
            
            self.navigationController?.present(browser, animated: true, completion: nil)
            
        }
        cell.cellBlock = { str in
            print("test block---\(str)")

        }
        cell.cell1Block = {
            (str) ->String in
            print("test block---\(str)")
            return str
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    /////
    func createLocalPhotos(urls:NSArray) -> [SKPhotoProtocol] {
        return (0..<urls.count).map { (i: Int) -> SKPhotoProtocol in
            let photo = SKPhoto.photoWithImageURL(urls[i] as! String)
            photo.caption = "我是这张图的描述"
            photo.contentMode = .scaleAspectFill
            return photo
        }
    }
    
}
