//
//  Router.swift
//  CoffeeRecorder-iOS
//
//  Created by 菅原実希 on 2024/11/04.
//

import UIKit

/// 画面遷移に関する処理を担うクラス
final class Router {
    static let shared = Router()
    private init() {}
    
    /// Home画面に画面遷移
    internal func showHomeView(from: UIViewController) {
        guard let toVC = UIStoryboard(name: "Home", bundle: nil)
            .instantiateInitialViewController() as? HomeViewController else { return }
        show(from: from, to: toVC)
    }
    
    /// Create画面に画面遷移
    internal func showCreateView(from: UIViewController) {
        guard let toVC = UIStoryboard(name: "Create", bundle: nil)
            .instantiateInitialViewController() as? CreateViewController else { return }
        show(from: from, to: toVC)
    }
}

private extension Router {

    func show(from: UIViewController, to: UIViewController, completion:(() -> Void)? = nil){
        if let nav = from.navigationController {
            nav.pushViewController(to, animated: true)
            completion?()
        } else {
            from.present(to, animated: true, completion: completion)
        }
    }
}
