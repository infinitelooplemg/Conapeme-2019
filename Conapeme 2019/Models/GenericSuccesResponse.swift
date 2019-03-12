//
//  GenericSuccesResponse.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


struct GenericSuccesResponse<T:Codable>:Codable {
    var code:Int
    var result:T?
    var sqlError:SQLError?
}


struct GenericSuccesMultipleResponse<T:Codable>:Codable {
    var code:Int
    var result:[T]?
    var sqlError:SQLError?
}
