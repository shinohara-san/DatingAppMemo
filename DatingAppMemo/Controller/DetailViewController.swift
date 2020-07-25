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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DataSource()
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
        vc.user = self.user
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

