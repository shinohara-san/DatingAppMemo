//
//  ModalViewController.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/26.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet weak var tweetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetButton.layer.cornerRadius = 10.0
        tweetButton.layer.shadowColor = UIColor.gray.cgColor
        tweetButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        tweetButton.layer.shadowOpacity = 0.3
        tweetButton.layer.shadowRadius = 10
    }
    
    @IBAction func tweetButtonTapped(_ sender: Any) {
        tweet()
    }
    
    func tweet(){
        let url = ""
        let text = "このアプリでマッチングしたユーザーを管理できます！インストールはこちら \(url)"
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let encodedText = encodedText,
            let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
