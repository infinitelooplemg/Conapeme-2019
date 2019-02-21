//
//  MasterViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit

class MasterViewController: UIViewController {
    var homeNC:UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHomeVC()
    }
    
    func addHomeVC(){
        let homeVC = HomeViewController(container: self)
        homeNC = UINavigationController(rootViewController: homeVC)
        add(asChildViewController: homeNC!)
    }
    
    func resetHomeMenu(){
        remove(asChildViewController: homeNC!)
        homeNC = nil
        homeNC = UINavigationController(rootViewController: HomeViewController(container: self))
        add(asChildViewController: homeNC!)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.addSubview(viewController.view)
        }, completion: nil)
    }
    
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
