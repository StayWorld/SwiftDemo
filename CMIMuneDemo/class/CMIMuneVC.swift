//
//  CMIMuneVC.swift
//  CMIMuneDemo
//
//  Created by 杨攀 on 2018/1/8.
//  Copyright © 2018年 CMIG. All rights reserved.
//

import UIKit

class CMIMuneVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuView = CMIMenuView(frame:CGRect(x:0, y:64, width:UIScreen.main.bounds.size.width, height: 44))
//        menuView.frame = CGRect(x:0, y:64, width:UIScreen.main.bounds.size.width, height: 44)
        self.view.addSubview(menuView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
