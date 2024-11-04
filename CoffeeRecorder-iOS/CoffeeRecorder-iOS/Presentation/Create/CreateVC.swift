//
//  CreateVC.swift
//  CoffeeRecorder-iOS
//
//  Created by 菅原実希 on 2024/11/04.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var coffeeNameTextField: UITextField!
    
    @IBOutlet weak var shopNameTextField: UITextField!
    
    @IBOutlet weak var rateSlider: UISlider!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func tappedCreateButton(_ sender: UIButton) {
        guard let enteredCoffeeName = coffeeNameTextField.text else { return }
        let enteredShopName = shopNameTextField.text ?? nil
        let enteredRate = rateSlider.value
        let enteredComment = commentTextField.text ?? nil
        let createdDate = Date()
        
        addNewCoffeeRecordItem(name: enteredCoffeeName, shopName: enteredShopName, rate: enteredRate, comment: enteredComment, createdDate: createdDate)
    }
    
    func addNewCoffeeRecordItem(name: String, shopName: String?, rate: Float, comment: String?, createdDate: Date) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCoffeeRecord = CoffeeRecord(context: context)
        newCoffeeRecord.name = name
        newCoffeeRecord.shopName = shopName
        newCoffeeRecord.rate = rate
        newCoffeeRecord.comment = comment
        newCoffeeRecord.createdDate = createdDate
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
