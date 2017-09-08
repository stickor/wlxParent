//
//  PMessageMapModel.swift
//  Parent
//
//  Created by osnail on 2017/9/1.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import ObjectMapper

class PMessageMapModel: Mappable {
    
    ///消息ID
    var messageId : NSInteger!;
    ///消息类型
    var type : NSString!;
    ///消息内容
    var content : NSString!;
    ///消息创建时间
    var creationDate : TimeInterval!;
    ///班级ID
    var gradeId : NSString!;
    ///是否已读
    var isRead : Int!;
    ///作业ID
    var homeworkId : NSString!;
    ///头像
    var avatarUrl : NSString!;
    ///老师的名字
    var teacherName : NSString!;
    ///公告的ID
    var noticId : NSString!;
    ///公告的内容
    var noticContent : NSString!;
    ///公告资源的类型
    var noticRestype : NSString!;
    ///公告的图片或视频资源
    var noticUrls = [String]();
    ///公告的视频预览图
    var noticPreUrl : NSString!;
    
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        messageId    <- map["messageId"]
        type         <- map["type"]
        content      <- map["content"]
        gradeId  <- map["gradeId"]
        isRead  <- map["isRead"]
        homeworkId     <- map["homeworkId"]
        avatarUrl    <- map["avatarUrl"]
        teacherName       <- map["teacherName"]
        noticId       <- map["noticId"]
        noticContent       <- map["noticContent"]
        noticRestype       <- map["noticRestype"]
        noticUrls       <- map["noticUrls"]
        noticPreUrl       <- map["noticPreUrl"]
        creationDate       <- map["creationDate"]
    }
}

//struct Temperature: Mappable {
//    var celsius: Double?
//    var fahrenheit: Double?
//    
//    init?(map: Map) {
//        
//    }
//    
//    mutating func mapping(map: Map) {
//        celsius     <- map["celsius"]
//        fahrenheit     <- map["fahrenheit"]
//    }
    
//}
