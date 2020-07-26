//
//  ViewController.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    var dataSource: DataSource!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        dataSource = DataSource() ///この1行!!!!
//        dataSource.printPath()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.getData(reload: tableView)
//        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dataSource.allPeople = [User]()
    }
    
    @IBAction func barButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "add") as! AddViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(dataSource.data(at: indexPath.row)?.name ?? "") さん"
        
        if dataSource.data(at: indexPath.row)?.rank == 1 {
            cell.detailTextLabel?.text = "🥇"
        } else if  dataSource.data(at: indexPath.row)?.rank == 2 {
            cell.detailTextLabel?.text = "🥈"
        } else if  dataSource.data(at: indexPath.row)?.rank == 3 {
            cell.detailTextLabel?.text = "🥉"
        } else {
            cell.detailTextLabel?.text = "第\(dataSource.data(at: indexPath.row)?.rank ?? 0)位"
        }
//        cell.detailTextLabel?.text = "第\(dataSource.data(at: indexPath.row)?.rank ?? 0)位"
//        print(indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "detail") as! DetailViewController
        vc.user = dataSource.data(at: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // TODO: 入れ替え時の処理を実装する（データ制御など）
        let user = dataSource.allPeople[sourceIndexPath.row]
        dataSource.allPeople.remove(at: sourceIndexPath.row)
        dataSource.allPeople.insert(user, at: destinationIndexPath.row)
        dataSource.updateRank()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
