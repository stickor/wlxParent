//
//  PMessageCenterCell.swift
//  Parent
//
//  Created by osnail on 2017/8/2.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import SnapKit
typealias ActionBlock = (String)->()
typealias Action1Block = (String)->String

class PMessageCenterCell: UITableViewCell {
    
    open lazy var tilte = UILabel()
    fileprivate lazy var timeLabel = UILabel()
    open lazy var content = UILabel()
    open lazy var actionBtn = UIButton()
    var cellBlock: ActionBlock?
    var cell1Block: Action1Block?
    
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
        self.setUI()
        
    }
    func setUI() {
        tilte.font = UIFont.systemFont(ofSize: 18)
        tilte.textColor = UIColor.black
        self.addSubview(tilte)
        
        content.font = UIFont.systemFont(ofSize: 14)
        content.numberOfLines = 0
        content.textColor = UIColor.lightGray
        self.addSubview(content)
        
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        self.addSubview(timeLabel)
//        actionBtn.backgroundColor = UIColor.orange
        actionBtn.setTitle("查看详情", for: UIControlState.normal)
        actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        actionBtn.setTitleColor(UIColor.orange)
        actionBtn.layer.borderWidth = 1
        actionBtn.layer.borderColor = UIColor.orange.cgColor
        actionBtn.layer.cornerRadius = 5
        actionBtn.addTarget(self, action: #selector(clickbtn), for: UIControlEvents.touchUpInside)
        
        self.addSubview(actionBtn)
        
        tilte.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-50)
            make.top.equalTo(self).offset(10)
        }
        content.snp.makeConstraints { (make) in
            make.top.equalTo(tilte.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        actionBtn.snp.remakeConstraints { (make) in
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }

    }
    
   open func updateWithData(data:NSDictionary) {
    
    let timeSta:TimeInterval = data.object(forKey: "creationDate") as! TimeInterval/1000
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy年MM月dd日- HH:mm"
    dfmatter.locale = Locale.current;
    let date = NSDate.init(timeIntervalSince1970: timeSta)
    let time = dfmatter.string(from: date as Date)
    tilte.text = data.object(forKey: "type") as? String
    content.text = data.object(forKey: "content") as? String
    let contentStr = data.object(forKey: "content") as? String
    content.text = contentStr?.appending("\n我如果爱你，绝不像攀援的凌霄花，借你的高枝炫耀自己；我如果爱你，绝不学痴情的鸟儿，为绿荫重复单调的歌曲；也不止像泉源，常年送来清凉的慰藉；也不止像险峰，增加你的高度，衬托你的威仪。甚至日光，甚至春雨。");
    timeLabel.text = time
    
    }
    
    func clickbtn() {
        self.cellBlock?("1111111")
        let result = self.cell1Block!("222")
        print("result = \(result)")
        
    }
    
   
}

