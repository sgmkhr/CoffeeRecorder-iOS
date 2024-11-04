//
//  HomeVC.swift
//  CoffeeRecorder-iOS
//
//  Created by 菅原実希 on 2024/11/02.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataUpdateDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [CoffeeRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        items = getAllCoffeeRecordArray()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        let date = items[indexPath.row].createdDate
        cell.detailTextLabel?.text = DateUtils.stringFromDate(date: date!, format: "yyyy/MM/dd HH:mm")
        return cell
    }
    
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
    
    @IBAction func tappedPlusButton(_ sender: UIBarButtonItem) {
        Router.shared.showCreateView(from: self)
    }
    
    func updateData(data: CoffeeRecord) {
        items.append(data)
        tableView.reloadData()
    }
}

protocol DataUpdateDelegate {
    func updateData(data: CoffeeRecord)
}
