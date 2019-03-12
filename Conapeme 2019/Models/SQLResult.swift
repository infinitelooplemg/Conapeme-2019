//
//  SQLSuccesfulOperation.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct SQLResult:Codable {
    var affectedRows:Int
    var changedRows:Int
    var fieldCount:Int
    var insertId:Int
    var message:String
    var protocol41:Bool
    var serverStatus:Int
    var warningCount:Int
    
}
