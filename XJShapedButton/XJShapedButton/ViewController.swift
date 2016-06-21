//
//  ViewController.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private var button: XJShapedButton = {
        let button = XJShapedButton()
        if let image = UIImage.init(named: "button-normal") {
            button.frame = CGRectMake(50, 50, 200, 200)
        }
        button.setImage(UIImage.init(named: "button-normal"), forState: .Normal)
        button.setImage(UIImage.init(named: "button-highlighted"), forState: .Highlighted)
        return button
    }()
    
    func setupView() {
        view.addSubview(button)
        button.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.width * 0.5)
        self.view.backgroundColor = UIColor.whiteColor()
        button.addTarget(self,
                         action: #selector(ViewController.buttonAction),
                         forControlEvents: .TouchUpInside)
    }
    
    func buttonAction() {
        print(1)
    }
}