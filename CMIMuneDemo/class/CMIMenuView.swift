//
//  CMIMenuView.swift
//  CMIMuneDemo
//
//  Created by 杨攀 on 2018/1/8.
//  Copyright © 2018年 CMIG. All rights reserved.
//

import UIKit



class CMIMenuView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var titles:[String]!
    var contents:[String] = []
    var presentInt:Int?
    var selectedBtnTag:Int?
    lazy var tableview:UITableView = { () -> (UITableView) in
        var tableview = UITableView(frame: CGRect(x: 0, y:44, width:self.screenWidth, height: 0), style: .plain)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:NSStringFromClass(UITableViewCell.self))
        tableview.isHidden = true
        return tableview
    }()
    lazy var bgView: UIView = { () -> (UIView) in
        var bgView = UIView()
        bgView.frame = CGRect(x:0, y:self.frame.maxY, width:screenWidth, height: screenHeight)
        bgView.backgroundColor = UIColor.red
        bgView.isHidden = true
        return bgView
    }()
    var btns:[UIButton] = []
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titles = ["默认价格", "购买人数"]
        setupViews()
        createTableView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 创建视图
    func setupViews() {
        var tag:Int = 0
        
        let width = UIScreen.main.bounds.size.width/CGFloat(titles.count)
        
        let image: UIImage! = UIImage.init(named: "muneNomalState")
        
        let imageWidth = image.size.width
        
        for title in titles {
            
            let titleWidth = title.titleSize(title)?.width
            let button = UIButton.init(type: .custom)
            button.frame = CGRect(x:(width*CGFloat(tag)), y:0, width:width, height:44)
            button.backgroundColor = UIColor.white
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setImage(UIImage.init(named: "muneNomalState"), for: .normal)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth! + 5, 0, -(titleWidth! + 5))
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + 5), 0, imageWidth + 5)
            button.tag = tag + 100
            button.addTarget(self, action: #selector(touchTitleFunc(_:)), for: .touchUpInside)
            self.addSubview(button)
            btns.append(button)
            tag += 1
        }
        let line = UIView()
        line.backgroundColor = UIColor.groupTableViewBackground
        line.frame = CGRect(x:0, y:44, width: screenWidth, height:1.0)
        self.addSubview(line)
        
    }
    func createTableView() {
        addSubview(bgView)
        addSubview(tableview)
    }
    // MARK:Pravite Methods
    @objc func touchTitleFunc(_ btn: UIButton) {
        for button in btns {
            if button == btn {
                button.isSelected = true
                button.transform(.pi)
            } else {
                button.isSelected = false
                button.transform(0)

            }
        }
        let isOpen = presentInt(btn.tag - 100)
        self.selectedBtnTag = btn.tag
        self.contents = byTagAction(btn.tag - 100)
        if isOpen{
            self.presentInt = btn.tag - 100
            openTableView()
        } else {
            closeTableView()
        }
        self.tableview.reloadData()
    }
    func presentInt(_ tag:Int) -> Bool {
        if tag == self.presentInt {
            return false
        } else {
            return true
        }
    }
    func openTableView() {
        self.tableview.isHidden = false
        self.bgView.isHidden = false
        var rect = self.tableview.frame
        rect.size.height = CGFloat(44 * self.contents.count)
        self.tableview.frame = rect
        self.frame.size.height = self.screenHeight
    }
    func closeTableView() {
        self.presentInt = 1000
        self.tableview.isHidden = true
        self.bgView.isHidden = true
        var rect = self.tableview.frame
        rect.size.height = 0
        self.tableview.frame = rect
        self.frame.size.height = 44
    }
    func byTagAction(_ tag:Int) -> [String] {
        if tag == 0 {
           return ["默认价格","价格1", "价格2", "价格3"]
        } else {
            return ["默认","多数人", "少数人"]
        }
    }
    // MARK: delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self))
        cell?.textLabel?.text = self.contents[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeTableView()
        
        let btn = self.viewWithTag(self.selectedBtnTag!) as? UIButton
        btn?.setTitle(self.contents[indexPath.row], for: .normal)
        btn?.transform(0)
    }
}
extension String {
    func titleSize(_ title:String) -> CGSize? {
        let font = UIFont.systemFont(ofSize: 16)
        
        let attr = [NSAttributedStringKey.font:font]
        
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let rect: CGRect = title.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width, height:1000), options: option, attributes: attr,context: nil)
        return rect.size
    }
}
extension UIButton {
    func transform(_ tranformAngle: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.imageView?.transform = CGAffineTransform.init(rotationAngle: tranformAngle)
        }
    }
}

