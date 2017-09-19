//
//  PShowImageCell.swift
//  Parent
//
//  Created by osnail on 2017/9/4.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import SnapKit

class PShowImageCell: UICollectionViewCell {
    
    
    open lazy var bgImageView = UIImageView()
    open lazy var videoImageView = UIImageView()
    
    override func awakeFromNib() {
        self.setUI()
    }
    override func encode(with aCoder: NSCoder) {
        self.setUI()
    }
    func setUI() {
        
//        self.bgImageView.bounds = self.bounds
//        self.bgImageView.center = self.center
        self.bgImageView.backgroundColor = UIColor.white
//        self.videoImageView.center = self.center
//        self.videoImageView.bounds = CGRect(x:0,y:0,width:30,height:30)
        self.videoImageView.image = #imageLiteral(resourceName: "playvideo")
        self.contentView.addSubview(bgImageView)
        self.contentView.addSubview(videoImageView)
        self.bgImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(self)
        }
        self.videoImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    func update(imageUrl:NSString)  {
        self.setUI()
        self.bgImageView.sd_setImage(with: URL(string: imageUrl as String ), placeholderImage: #imageLiteral(resourceName: "zweiSquare"))
        
    }
    
}
