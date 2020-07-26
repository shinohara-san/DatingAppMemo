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
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var matchDayField: UITextField!
    @IBOutlet weak var impressionField: UITextView!
    @IBOutlet weak var goodTopicField: UITextView!
    @IBOutlet weak var badTopicField: UITextView!
    @IBOutlet weak var dateTodoField: UITextView!
    var dataSource: DataSource!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    //    var user: User?
    let screenSize = UIScreen.main.bounds.size
    var screenHeight:CGFloat!
    var screenWidth:CGFloat!
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "新規入力"
        
        saveButton.layer.cornerRadius = 10
        saveButton.layer.shadowColor = UIColor.gray.cgColor
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        saveButton.layer.shadowOpacity = 0.3
        saveButton.layer.shadowRadius = 10

        nameField.delegate = self
        matchDayField.delegate = self
        impressionField.delegate = self
        goodTopicField.delegate = self
        badTopicField.delegate = self
        dateTodoField.delegate = self
        
        dataSource = DataSource() ///この1行!!!!
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        return true
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
        
//        let num = dataSource.count()
        
        newMatch.id = UUID().uuidString
        newMatch.name = name
        newMatch.matchDay = matchDay
        newMatch.rank = dataSource.getRank()
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
