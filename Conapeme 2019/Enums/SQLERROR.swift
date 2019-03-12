//
//  SQLERROR.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/12/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

enum SQLErrorCode:Int {
    case ER_DUP_ENTRY = 1062
    
    var description: (String) {
        switch self {
        case .ER_DUP_ENTRY:
            return "El usuario ya se encuentra registrado en este taller"
        default:
            return "Error de base de datos,vuelva a intentarlo"
        }
    }
}
