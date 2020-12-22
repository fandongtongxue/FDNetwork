//
//  ViewController.swift
//  FDNetworkDemo
//
//  Created by 范东同学 on 2020/1/14.
//  Copyright © 2020 fandong. All rights reserved.
//

import UIKit
import FDNetwork

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        // Do any additional setup after loading the view.
//        FDNetwork.GET(url: "http://httpbin.org/get", param: nil, success: { (result) in
//            let model = FDHTTPTestModel.deserialize(from: result)
//            print(model?.toJSONString())
//        }) { (msg) in
//            print(msg)
//        }
//        FDNetwork.POST(url: "http://httpbin.org/post", param: nil, success: { (result) in
//            let model = FDHTTPTestModel.deserialize(from: result)
//            print(model?.toJSONString())
//        }) { (msg) in
//            print(msg)
//        }
        
//        FDNetwork.DOWNLOAD(url: "https://dldir1.qq.com/qqfile/QQIntl/QQi_PC/QQIntl2.11.exe", path: "/Users/www1/Documents/1.exe", progress: { (progress) in
//            print(progress)
//        }, success: { (result) in
//            print(result)
//        }) { (error) in
//            print(error)
//        }
    }
}
