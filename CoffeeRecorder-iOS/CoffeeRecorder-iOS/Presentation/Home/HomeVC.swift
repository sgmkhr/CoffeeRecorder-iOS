//
//  HomeVC.swift
//  CoffeeRecorder-iOS
//
//  Created by 菅原実希 on 2024/11/02.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataUpdateDelegate {
    
    // MARK: - outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - propaties
    var items: [CoffeeRecord] = []
    let refresh = UIRefreshControl()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        items = getAllCoffeeRecordArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    // MARK: - table view method

    //セル数の指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // セル表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        let date = items[indexPath.row].createdDate
        cell.detailTextLabel?.text = DateUtils.stringFromDate(date: date, format: "yyyy/MM/dd HH:mm")
        return cell
    }
    
    // スワイプ削除
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - action
    
    @IBAction func tappedPlusButton(_ sender: UIBarButtonItem) {
            Router.shared.showCreateView(from: self)
        }

    // MARK: - method
    func getAllCoffeeRecordArray() -> [CoffeeRecord] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let savedPlaceFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CoffeeRecord")
        do {
            let result = try context.fetch(savedPlaceFetch)
            if let convertedResult = result as? [CoffeeRecord] {
                return convertedResult
            }
        } catch {
            return []
        }
        return []
    }
    
    func updateData(data: CoffeeRecord) {
        items.append(data)
        tableView.reloadData()
    }
    
    @objc func refreshData() {
        refresh.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - protocol
protocol DataUpdateDelegate {
    func updateData(data: CoffeeRecord)
}
