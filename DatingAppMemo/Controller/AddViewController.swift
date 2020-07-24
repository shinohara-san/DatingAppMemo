//
//  AddViewController.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var matchDayField: UITextField!
    @IBOutlet weak var impressionField: UITextView!
    @IBOutlet weak var goodTopicField: UITextView!
    @IBOutlet weak var badTopicField: UITextView!
    @IBOutlet weak var dateTodoField: UITextView!
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        matchDayField.delegate = self
        impressionField.delegate = self
        goodTopicField.delegate = self
        badTopicField.delegate = self
        dateTodoField.delegate = self
        
        dataSource = DataSource() ///この1行!!!!
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.emptyFields()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let newMatch = User()
        guard let name = nameField.text else {return}
        guard let matchDay = matchDayField.text else {return}
        
        if name == "" || matchDay == "" {
            showNgAlert()
            return
        }
        
        let impression = impressionField.text
        let goodTopic = goodTopicField.text
        let badTopic = badTopicField.text
        let todoOnDate = dateTodoField.text
        
        newMatch.id = UUID().uuidString
        newMatch.name = name
        newMatch.matchDay = matchDay
        newMatch.impression = impression ?? ""
        newMatch.goodTopic = goodTopic ?? ""
        newMatch.badTopic = badTopic ?? ""
        newMatch.todoOnDate = todoOnDate ?? ""
        
        dataSource.saveData(of: newMatch)
        
        showOkAlert()
    }
    
    func emptyFields(){
        nameField.text = ""
        matchDayField.text = ""
        impressionField.text = ""
        goodTopicField.text = ""
        badTopicField.text = ""
        dateTodoField.text = ""
    }
    
    func showOkAlert(){
        let ac = UIAlertController(title: "保存しました", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "入力を終了する", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        ac.addAction(UIAlertAction(title: "追加で入力する", style: .default, handler: { (_) in
            self.emptyFields()
        }))
        present(ac, animated: true)
    }
    
    func showNgAlert(){
        let ac = UIAlertController(title: "エラー", message: "お名前とマッチした日は必須です。", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    
    
}
