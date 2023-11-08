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
        FDNetwork.GET(url: "http://httpbin.org/get", param: ["tet":1], success: { (result) in
            debugPrint(result)
        }) { (msg) in
            debugPrint(msg)
        }
        FDNetwork.POST(url: "http://httpbin.org/post", param: nil, success: { (result) in
            debugPrint(result)
        }) { (msg) in
            debugPrint(msg)
        }
    }
}
