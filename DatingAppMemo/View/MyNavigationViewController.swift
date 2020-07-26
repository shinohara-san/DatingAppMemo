//
//  MyNavigationViewController.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class MyNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //　ナビゲーションバーの背景色
        navigationBar.barTintColor = UIColor(red: 238/255, green: 143/255, blue: 143/255, alpha: 1)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        navigationBar.titleTextAttributes = [
            // 文字の色
        .foregroundColor: UIColor.white
        ]
    }

}
