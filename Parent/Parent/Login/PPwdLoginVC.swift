//
//  PPwdLoginVC.swift
//  Parent
//
//  Created by osnail on 2017/7/26.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import JHB_HUDView
import Alamofire


class PPwdLoginVC: PViewController {
    @IBOutlet var phoneNum: UITextField!
    @IBOutlet var pwdText: UITextField!
    @IBOutlet var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onClickLoginBtn(_ sender: UIButton) {
        if (phoneNum.text?.length)!<1 {
            JHB_HUDView.showMsg("手机号不能为空")
            return;
        }
        if (pwdText.text?.length)!<1 {
            JHB_HUDView.showMsg("密码不能为空")
            return;
        }
        let param = [
            "type": "",
            "key" : ""
        ]
        Alamofire.request("12345678", method: .post, parameters: param).responseJSON { (returnResult) in
            print("secondMethod --> 参数 --> returnResult = \(returnResult)")
        }
        
        
    }
    

}
