//
//  RequestManager.swift
//  Parent
//
//  Created by osnail on 2017/8/8.
//  Copyright © 2017年 osnail. All rights reserved.
//

import UIKit

class RequestManager: NSObject {

    open func request(type: NSString, urlString: NSString, parameters: NSDictionary) -> URLRequest {
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
        urlRequest.setValue("b3d9761b-10a2-4c85-a3d9-f59d7829c93e", forHTTPHeaderField: "token")
        
        return urlRequest;
    }
    
}
