//
//  Character+.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/27.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

extension Character {
    
    var initiality: Character? {
        guard let scalar = "\(self)".normalize(.NFKD).unicodeScalars.first else { return nil }
        
        return Character(scalar)
    }
}
