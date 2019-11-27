//
//  String+.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/25.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

extension String {
    
    var chacters: [Character] {
        return self.map { $0 as Character }
    }
    
    var firstSpell: String? {
        guard let firstSpell = self.first?.initiality else { return nil }
        return String(firstSpell)
    }
    
    func normalize(_ form: NormalizationForm) -> String {
        switch form {
        case .NFD: return self.decomposedStringWithCanonicalMapping
        case .NFC: return self.precomposedStringWithCanonicalMapping
        case .NFKD: return self.decomposedStringWithCompatibilityMapping
        case .NFKC: return self.precomposedStringWithCompatibilityMapping
        }
    }
    
    var isCompletion: Bool {
        self.chacters
            .map { "\($0)" }
            .reduce(false) {
               $1.normalize(.NFC).unicodeScalars.count != $1.normalize(.NFD).unicodeScalars.count
                || $0
        }
    }
    
    enum NormalizationForm {
        case NFD
        case NFC
        case NFKD
        case NFKC
    }
}
