//
//  PMessageCenterModel.swift
//  Parent
//
//  Created by osnail on 2017/8/31.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit

class PMessageCenterResModel: PBaseModel {
    
    var code: Int!
    var message: NSString!
    var data: NSString!
    
}
class MessageDataModel: PBaseModel {
    lazy var content_list : [PMessageCenterModel] = [PMessageCenterModel]()

    var isLast: Bool!
    var content : [[String : Any]]? {
        didSet {
            guard let room_list2 = content else { return }
            for dict in room_list2 {
                content_list.append(PMessageCenterModel(dicToModel: dict))
            }
        }
    }
    
}

class PMessageCenterModel: PBaseModel {
    ///消息ID
    var messageId : NSInteger = 0;
    ///消息类型
    var type : NSString = "";
    ///消息内容
    var content : NSString = "";
    ///消息创建时间
    var creationDate : TimeInterval = 0;
    ///班级ID
    var gradeId : NSString = "";
    ///是否已读
    var isRead : Int = 0;
    ///作业ID
    var homeworkId : NSString = "";
    ///头像
    var avatarUrl : NSString = "";
    ///老师的名字
    var teacherName : NSString = "";
    ///公告的ID
    var noticId : NSString = "";
    ///公告的内容
    var noticContent : NSString = "";
    ///公告资源的类型
    var noticRestype : NSString = "";
    ///公告的图片或视频资源
    var noticUrls = [String]();
    ///公告的视频预览图
    var noticPreUrl : NSString!;
    
}
