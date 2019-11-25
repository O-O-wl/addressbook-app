//
//  String+.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/25.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

extension String {
    
    var firstSpell: String? {
        guard let scalar = self.unicodeScalars.first else { return nil }
        
        switch scalar.value {
        case 0xAC00...0xD7A3:
            let firstSpell = UnicodeScalar((scalar.value - 0xAC00) / 28 / 21 + 0x1100)
            return firstSpell?.description
        default:
            return scalar.description
        }
    }
}
