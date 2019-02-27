//
//  StreamViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/27/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit
import iOSPlayerSDK

class LiveViewController: UIViewController,USPlayerDelegate {
    
    
    
    var usstreamPlayter: USUstreamPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usstreamPlayter = USUstreamPlayer()
        usstreamPlayter?.delegate = self
        usstreamPlayter?.view.frame = self.view.bounds
        view.addSubview(usstreamPlayter!.view)
        
        var mediadescriptor =  USMediaDescriptor.channelDescriptor(withID: "23639470")
        usstreamPlayter?.playMedia(mediadescriptor)
        

        
        
        //        USMediaDescriptor *mediaDescriptor = [USMediaDescriptor channelDescriptorWithID:<#place your channel ID here#>];
        //        [self.ustreamPlayer playMedia:mediaDescriptor];
        
        // Do any additional setup after loading the view, typically from a nib.
        
        setupNavitagionItems()
    }
    
    
    func setupNavitagionItems(){
        navigationItem.title = "En Vivo"
        let menuButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(dismisVC))
        navigationItem.setLeftBarButton(menuButton, animated: true)
    }
    
    @objc func dismisVC(){
        dismiss(animated: true, completion: nil)
    }
}
