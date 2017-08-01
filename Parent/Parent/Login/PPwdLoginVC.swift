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
            "username": "13294192422",
            "password" : "666666",
            "loginType":"pwd"
        ]
        
        let url = URL(string: "http://192.168.10.4:8101/login")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let parameters = param
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            // No-op
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("v3", forHTTPHeaderField: "interface_version")
        urlRequest.setValue("iphone", forHTTPHeaderField: "system")
        urlRequest.setValue("ios10", forHTTPHeaderField: "version")
        urlRequest.setValue("123456789", forHTTPHeaderField: "guid")
        urlRequest.setValue("1.5.0", forHTTPHeaderField: "app_version")
        urlRequest.setValue("App Store", forHTTPHeaderField: "channel")
        urlRequest.setValue("20170101", forHTTPHeaderField: "build_version")
        urlRequest.setValue("", forHTTPHeaderField: "token")

        Alamofire.request(urlRequest).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            if let data = response.data,
                let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            //是否请求成功
            if response.result.isSuccess{

            }
            if let jsonValue = response.result.value {
                print(jsonValue)
            }
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
