//
//  SQLError.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
class SQLError:Codable {
    var code:String
    var errno:Int
    var index:Int
    var sql:String
    var sqlMessage:String
    var sqlState:String
}

