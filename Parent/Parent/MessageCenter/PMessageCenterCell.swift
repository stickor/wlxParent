//
//  PMessageCenterCell.swift
//  Parent
//
//  Created by osnail on 2017/8/2.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit

class PMessageCenterCell: UITableViewCell {
    
    open lazy var tilte = UILabel()
    open lazy var content = UILabel()
    fileprivate lazy var timeLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //        tilte.frame = CGRect(x: ,y: ,width: ,height: )
        self.setUI()
        
    }
    func setUI() {
        
        tilte.frame = CGRect(x:10 ,y:10 ,width:100 ,height:20 )
        tilte.font = UIFont.systemFont(ofSize: 18)
        tilte.textColor = UIColor.black
        self.addSubview(tilte)
        
        content.frame = CGRect(x:10 ,y:30 ,width:self.frame.size.width-30 ,height:self.frame.size.height-30)
        content.font = UIFont.systemFont(ofSize: 14)
        content.textColor = UIColor.lightGray
        self.addSubview(content)
        
        
        timeLabel.frame = CGRect(x: self.frame.size.width-100,y:10 ,width:80 ,height:20)
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        self.addSubview(timeLabel)
        
        tilte.text = "111111"
        content.text = "222222222222222"
        timeLabel.text = "2017-01-01"
    }
    
    
    
   open func updateWithData(data:NSDictionary) {
        tilte.text = data.object(forKey: "title") as? String
        content.text = data.object(forKey: "content") as? String
        timeLabel.text = data.object(forKey: "timeLabel") as? String
        
        
    }
   
}

