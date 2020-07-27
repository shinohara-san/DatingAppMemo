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
        navigationBar.barTintColor = MyColor.peach
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        navigationBar.tintColor = MyColor.white
        // ナビゲーションバーのテキストを変更する
        navigationBar.titleTextAttributes = [
            // 文字の色
        .foregroundColor: UIColor.white
        ]
    }

}
