//
//  HomeVC.swift
//  CoffeeRecorder-iOS
//
//  Created by 菅原実希 on 2024/11/02.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tappedCreateButton(_ sender: UIButton) {
        Router.shared.showCreateView(from: self)
    }
}
