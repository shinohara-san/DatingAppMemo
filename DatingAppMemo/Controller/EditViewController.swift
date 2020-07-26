//
//  EditViewController.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/25.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var user: User!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var matchDayField: UITextField!
    @IBOutlet weak var impressionField: UITextView!
    @IBOutlet weak var goodTopicField: UITextView!
    @IBOutlet weak var badTopicField: UITextView!
    @IBOutlet weak var dateTodoField: UITextView!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var updateButton: UIButton!
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "\(user.name) さん 編集ページ"
        updateButton.layer.cornerRadius = 10
        updateButton.layer.shadowColor = UIColor.gray.cgColor
        updateButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        updateButton.layer.shadowOpacity = 0.3
        updateButton.layer.shadowRadius = 10
        
        nameField.delegate = self
        matchDayField.delegate = self
        impressionField.delegate = self
        goodTopicField.delegate = self
        badTopicField.delegate = self
        dateTodoField.delegate = self
        
        dataSource = DataSource()
        
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        matchDayField.inputView = datePicker
        
        //DONEボタンの設定・配置
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        matchDayField.inputAccessoryView = toolbar
        
        nameField.text = user.name
        matchDayField.text = user.matchDay
        impressionField.text = user.impression
        goodTopicField.text = user.goodTopic
        badTopicField.text = user.badTopic
        dateTodoField.text = user.todoOnDate
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func done() {
        matchDayField.endEditing(true)
        // 日付のフォーマット
        let matchdate = datePicker.date
        let components = Calendar.current.dateComponents([.calendar, .year, .month, .day], from: matchdate)
        
        var comp = DateComponents()
        comp.year = components.year
        comp.month = components.month
        comp.day = components.day
        
        guard let date = (Calendar.init(identifier: .japanese)).date(from: comp) else {return}
        
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd"
        
        matchDayField.text = "\(formatter.string(from: date))"
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        guard let name = nameField.text else {
            return
        }
        guard let matchDay = matchDayField.text else {
            return
        }
        
        if name == "" || matchDay == ""{
            showNgAlert()
        }
        
        let updatedUser = User()
        updatedUser.id = user.id
        updatedUser.name = name
        updatedUser.matchDay = matchDay
        updatedUser.impression = impressionField.text ?? ""
        updatedUser.goodTopic = goodTopicField.text ?? ""
        updatedUser.badTopic = badTopicField.text ?? ""
        updatedUser.todoOnDate = dateTodoField.text ?? ""
        
        dataSource.updateData(of: updatedUser)
        showOkAlert()
    }
    
    func showOkAlert(){
        let ac = UIAlertController(title: "保存しました", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(ac, animated: true)
    }
    
    func showNgAlert(){
        let ac = UIAlertController(title: "エラー", message: "お名前とマッチした日は必須です。", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
}
