//
//  Array+.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/27.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

extension Array where Element == Character {
    
    func hasPrefix(_ other: Self) -> Bool {
        let range = 0..<Swift.min(self.count, other.count)
        return self[range] == other[range]
    }
}
