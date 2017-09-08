//
//  PShowImageCell.swift
//  Parent
//
//  Created by osnail on 2017/9/4.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit

class PShowImageCell: UICollectionViewCell {
    
    
    fileprivate lazy var bgImageView = UIImageView()
    fileprivate lazy var videoImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.setUI()
    }

    override func awakeFromNib() {
        self.setUI()
    }
    func setUI() {
        
        self.bgImageView.frame = self.bounds
        self.videoImageView.center = self.center
        self.videoImageView.frame = CGRect(x:0,y:0,width:30,height:30)
        self.videoImageView.image = #imageLiteral(resourceName: "playvideo")
        self.contentView.addSubview(bgImageView)
        self.contentView.addSubview(videoImageView)
        
    }
    
    func update(imageUrl:NSString)  {
        
        self.bgImageView.sd_setImage(with: URL(string: imageUrl as String ), placeholderImage: #imageLiteral(resourceName: "zweiSquare"))
        
    }
    
}
