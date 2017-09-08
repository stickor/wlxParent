//
//  PBaseModel.swift
//  Parent
//
//  Created by osnail on 2017/8/31.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit

class PBaseModel: NSObject {
    override init() {
        super.init()
    }
    
    init(dicToModel: [String: Any]) {
        super.init()
        setValuesForKeys(dicToModel)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
