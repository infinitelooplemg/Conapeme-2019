//
//  FastSigninResponse.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct FastSigninResponse:Codable {
    var code:Int
    var result:Assistant?
    var errorMessage:String?
}
