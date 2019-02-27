//
//  UserProfileScreen.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit
import Disk
class UserProfileViewController:UIViewController {
    
    weak var delegate:SignouDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        let dismissButton = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem = dismissButton
        let signoutButton = UIBarButtonItem(title: "Salir", style: .plain, target: self, action: #selector(signout))
        navigationItem.rightBarButtonItem = signoutButton
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signout(){
        do {
            try   Disk.remove("credentials.json", from: .documents)
            dismiss(animated: true) {
                self.delegate?.userDidSignout()
            }
        } catch  {}
    }
}
