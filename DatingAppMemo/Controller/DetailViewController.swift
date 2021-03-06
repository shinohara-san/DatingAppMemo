//
//  DetailViewController.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var user: User!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var matchDayField: UILabel!
    @IBOutlet weak var impressionField: UILabel!
    @IBOutlet weak var goodTopicField: UILabel!
    @IBOutlet weak var badTopicField: UILabel!
    @IBOutlet weak var dateTodoField: UILabel!
    var dataSource: DataSource!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DataSource()
        self.navigationItem.title = "\(user.name) さん 詳細ページ"
        
        editButton.layer.cornerRadius = 10
        deleteButton.layer.cornerRadius = 10
        editButton.layer.shadowColor = UIColor.gray.cgColor
        editButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        editButton.layer.shadowOpacity = 0.3
        editButton.layer.shadowRadius = 10
        deleteButton.layer.shadowColor = UIColor.gray.cgColor
        deleteButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        deleteButton.layer.shadowOpacity = 0.3
        deleteButton.layer.shadowRadius = 10
        
        nameField.textColor = MyColor.black
        matchDayField.textColor = MyColor.black
        impressionField.textColor = MyColor.black
        goodTopicField.textColor = MyColor.black
        badTopicField.textColor = MyColor.black
        dateTodoField.textColor = MyColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = user.name
        matchDayField.text = user.matchDay
        impressionField.text = user.impression
        goodTopicField.text = user.goodTopic
        badTopicField.text = user.badTopic
        dateTodoField.text = user.todoOnDate
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "edit") as! EditViewController
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        dataSource.delete(user: user)
        showDeleteNotification()
        
    }
    
    func showDeleteNotification(){
        let ac = UIAlertController(title: "削除", message: "このユーザーを削除しました", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        present(ac, animated: true)
    }
    
}

