//
//  PMessageCenterCell.swift
//  Parent
//
//  Created by osnail on 2017/8/2.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
typealias ActionBlock = (String)->()
typealias Action1Block = (String)->String
typealias playVideoBlock = (String) ->()
typealias showImageDetailBlock = (NSInteger,NSArray,NSArray) ->()

class PMessageCenterCell: UITableViewCell ,UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    fileprivate lazy var logoImage = UIImageView()
    open lazy var tilte = UILabel()
    fileprivate lazy var timeLabel = UILabel()
    open lazy var content = UILabel()
    fileprivate lazy var collectionView = UICollectionView()
    open lazy var actionBtn = UIButton()
    fileprivate lazy var resouceDataArray = NSArray()
    fileprivate lazy var noticeModel = PMessageCenterModel()
    
    
    var cellBlock: ActionBlock?
    var cell1Block: Action1Block?
    var playVideoBlock : playVideoBlock?
    var showImageDetailBlock : showImageDetailBlock?
    
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
        
        logoImage.layer.masksToBounds = true
        logoImage.layer.cornerRadius = 15
        self.contentView.addSubview(logoImage)
        
        tilte.font = UIFont.systemFont(ofSize: 18)
        tilte.textColor = UIColor.black
        self.contentView.addSubview(tilte)
        
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.gray
        self.contentView.addSubview(timeLabel)
        
        content.font = UIFont.systemFont(ofSize: 14)
        content.numberOfLines = 0
        content.textColor = UIColor.lightGray
        self.contentView.addSubview(content)
        
        
        
        
//        layout.minimumLineSpacing = 3
//        layout.scrollDirection = UICollectionViewScrollDirection.vertical

        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 30, height: 30)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
//        self.collectionView.collectionViewLayout = layout
        self.collectionView = UICollectionView(frame: CGRect(x:0,y:0,width:0,height:0), collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.color(string: "f0f0f0")
        self.collectionView.register(PShowImageCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.isScrollEnabled = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.contentView.addSubview(collectionView)
        
        actionBtn.setTitle("查看详情", for: UIControlState.normal)
        actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        actionBtn.setTitleColor(UIColor.orange)
        actionBtn.layer.borderWidth = 1
        actionBtn.layer.borderColor = UIColor.orange.cgColor
        actionBtn.layer.cornerRadius = 5
        actionBtn.addTarget(self, action: #selector(clickbtn), for: UIControlEvents.touchUpInside)
        self.contentView.addSubview(actionBtn)
        
        
        //添加位置frame
        logoImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        tilte.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(logoImage)
            make.left.equalTo(logoImage.snp.right).offset(10)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.contentView).offset(-50)
            make.top.equalTo(self.contentView).offset(10)
        }
        content.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(collectionView.snp.top)
        }
        collectionView.snp.remakeConstraints { (make) in
            make.trailing.equalTo(content)
            make.bottom.equalTo(actionBtn.snp.top)
            make.leading.equalTo(content)
            make.height.equalTo(0)
        }
        actionBtn.snp.remakeConstraints { (make) in
            make.trailing.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(80)
            make.height.equalTo(0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.noticeModel.noticUrls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PShowImageCell
        
        
        if self.noticeModel.noticRestype.isEqual(to: "IMAGE") {
            cell.update(imageUrl: self.noticeModel.noticUrls[indexPath.row] as NSString)
            cell.videoImageView.isHidden = true
        }else{
            cell.update(imageUrl: self.noticeModel.noticPreUrl)
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let urlsCount =  self.noticeModel.noticUrls.count
        var collectionCellHeight = CGFloat()
        if urlsCount == 1 {
            collectionCellHeight = (UIScreen.screenWidth-20)*2/3
             return CGSize(width:UIScreen.screenWidth-20,height:collectionCellHeight)
        }else{
            if urlsCount>0 {
                collectionCellHeight = (UIScreen.screenWidth-20)/3
            }
        }
        return CGSize(width:collectionCellHeight,height:collectionCellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.noticeModel.noticRestype.isEqual(to: "IMAGE") {
            let imageViews = NSMutableArray()
            for index in 1...self.noticeModel.noticUrls.count {
                let cell = collectionView.cellForItem(at: NSIndexPath.init(row: index, section: indexPath.section) as IndexPath)
                imageViews.add(cell ?? PShowImageCell())
            }
            
            if (self.showImageDetailBlock != nil) {
                self.showImageDetailBlock!(indexPath.row,self.noticeModel.noticUrls as NSArray,imageViews)
            }
            
        }else{
            if (self.playVideoBlock != nil) {
                self.playVideoBlock!(self.noticeModel.noticUrls[0])
            }
        }
    }
    
    
   open func updateWithData(data:PMessageCenterModel) {
    
    
    let timeSta:TimeInterval = data.creationDate/1000
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy年MM月dd日- HH:mm"
    dfmatter.locale = Locale.current;
    let date = NSDate.init(timeIntervalSince1970: timeSta)
    let time = dfmatter.string(from: date as Date)
    
    var avatarUrl = ""
    avatarUrl = data.avatarUrl as String
    
    var teacherName = "未来星艺术中心"
    if (data.teacherName).boolValue {
        teacherName = data.teacherName as String
    }
    
    
    
    
    if data.type.isEqual(to: "SYSTEM_MSG") {//系统消息
        self.tilte.text = "未来星艺术中心";
        self.logoImage.image =  #imageLiteral(resourceName: "wlxxLogo")
    }
    else if data.type.isEqual(to: "GRADE_MSG"){//班级消息
        self.logoImage.sd_setImage(with: URL(string: avatarUrl ), placeholderImage: UIImage(named: "defaultteacher.png"))
        self.tilte.text = teacherName
        if data.isRead == 1{
            self.actionBtn.isHidden = true
        }else{
            self.actionBtn.isHidden = false
            self.actionBtn.setTitleColor(UIColor.white)
            self.actionBtn.setTitle("我知道了", for: UIControlState.normal)
            self.actionBtn.backgroundColor = UIColor.init(hex: "f86537")
            self.actionBtn.snp.updateConstraints({ (make) in
                make.trailing.equalTo(self.contentView).offset(-10)
                make.bottom.equalTo(self.contentView).offset(-10)
                make.width.equalTo(80)
                make.height.equalTo(30)
            })
        }
    }
    else if data.type.isEqual(to: "ACCOUNT_MSG"){//账号关联
        self.tilte.text = "未来星艺术中心";
        self.logoImage.image =  #imageLiteral(resourceName: "wlxxLogo")
    }
    else if data.type.isEqual(to: "HOMEWORK"){
        self.logoImage.sd_setImage(with: URL(string: avatarUrl ), placeholderImage: UIImage(named: "defaultteacher.png"))
        self.tilte.text = teacherName
        
        self.actionBtn.isHidden = false
        self.actionBtn.setTitle("查看详情", for: UIControlState.normal)
        self.actionBtn.layer.borderWidth = 1
        self.actionBtn.layer.borderColor = UIColor.orange.cgColor
        self.actionBtn.layer.cornerRadius = 5
        self.actionBtn.snp.updateConstraints({ (make) in
            make.trailing.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(80)
            make.height.equalTo(30)
        })
        
    }
    else{//NOTICE_MSG 公告
        self.logoImage.sd_setImage(with: URL(string: avatarUrl ), placeholderImage: UIImage(named: "defaultteacher.png"))
        self.tilte.text = teacherName
        self.noticeModel = data
        self.collectionView.reloadData()
        
        
        let urlsCount =  data.noticUrls.count
        var collectionHeight = CGFloat()
        var heightCount = CGFloat()
        
        if urlsCount == 1 {
            collectionHeight = (UIScreen.screenWidth-20)*2/3
        }else{
            heightCount = CGFloat(urlsCount/3+1)
            if urlsCount>0 && urlsCount % 3 == 0{
                heightCount = CGFloat(urlsCount/3)
            }
            if urlsCount == 0{
                heightCount = 0
            }
            collectionHeight = (UIScreen.screenWidth-20)/3 * heightCount
        }
        
        
        collectionView.snp.updateConstraints { (make) in
            make.trailing.equalTo(content)
            make.bottom.equalTo(actionBtn.snp.top).offset(-10)
            make.leading.equalTo(content)
            make.height.equalTo(collectionHeight)
        }
        
        if data.isRead == 1{
            self.actionBtn.isHidden = true
        }else{
            self.actionBtn.isHidden = false
            self.actionBtn.setTitleColor(UIColor.white)
            self.actionBtn.setTitle("我知道了", for: UIControlState.normal)
            self.actionBtn.backgroundColor = UIColor.init(hex: "f86537")
            self.actionBtn.snp.updateConstraints({ (make) in
                make.trailing.equalTo(self.contentView).offset(-10)
                make.bottom.equalTo(self.contentView).offset(-10)
                make.width.equalTo(80)
                make.height.equalTo(30)
            })
        }
    }
    
    content.text = data.content as String
    let contentStr = data.content as String
    content.text = contentStr.appending("\n我如果爱你，绝不像攀援的凌霄花，借你的高枝炫耀自己；我如果爱你，绝不学痴情的鸟儿，为绿荫重复单调的歌曲；也不止像泉源，常年送来清凉的慰藉；也不止像险峰，增加你的高度，衬托你的威仪。甚至日光，甚至春雨。");
    timeLabel.text = time
    
    
    }
    
    func clickbtn() {
        self.cellBlock?("1111111")
        let result = self.cell1Block!("222")
        print("result = \(result)")
        
    }
    
   
}

