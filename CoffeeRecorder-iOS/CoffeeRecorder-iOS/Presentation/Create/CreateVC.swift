//
//  CreateVC.swift
//  CoffeeRecorder-iOS
//
//  Created by 菅原実希 on 2024/11/04.
//

import UIKit
import CoreData

class CreateViewController: UIViewController {
    
    @IBOutlet weak var coffeeNameTextField: UITextField!
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    var delegate: DataUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tappedCreateButton(_ sender: UIButton) {
        guard let enteredCoffeeName = coffeeNameTextField.text else { return }
        let enteredShopName = shopNameTextField.text ?? nil
        let enteredRate = rateLabel.text ?? "2.5"
        let enteredComment = commentTextField.text ?? nil
        let createdDate = Date()
        
        addNewCoffeeRecordItem(name: enteredCoffeeName, shopName: enteredShopName, rateText: enteredRate, comment: enteredComment, createdDate: createdDate)
    }
    
    @IBAction func InputSliderRate(_ sender: UISlider) {
        rateLabel.text = "\(sender.value)"
    }
    
    
    func addNewCoffeeRecordItem(name: String, shopName: String?, rateText: String, comment: String?, createdDate: Date) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCoffeeRecord = CoffeeRecord(context: context)
        newCoffeeRecord.name = name
        newCoffeeRecord.shopName = shopName
        newCoffeeRecord.rate = Double(rateText)!
        newCoffeeRecord.comment = comment
        newCoffeeRecord.createdDate = createdDate
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        delegate?.updateData(data: newCoffeeRecord)
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
