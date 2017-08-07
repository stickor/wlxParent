//
//  PRequestManager.swift
//  Parent
//
//  Created by osnail on 2017/8/3.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class PRequestManager: NSObject {
    
   open func request(type: NSString, urlString: NSString, parameters: NSDictionary) -> JSON {
        var strUrl = "http://58.49.120.22:28101"
        strUrl = strUrl.appending(urlString as String)
    
        let url = URL(string: strUrl as String)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type as String
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters ,options: [])
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
        urlRequest.setValue("26b18824-4e62-4e9b-b614-3622fff55d41", forHTTPHeaderField: "token")
        var resultDic = JSON.init(AnyClass.self)
        Alamofire.request(urlRequest).responseJSON { response in
            
            if response.result.isSuccess{
                let json = JSON(data: response.data!)
                print(json["code"])
                resultDic = json
//                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                    print("Data: \(utf8Text)")
//                }
//                }
//                if let jsonValue = response.result.value {
//                    print(jsonValue)
//                }

        }
    }
    return resultDic
}
}
