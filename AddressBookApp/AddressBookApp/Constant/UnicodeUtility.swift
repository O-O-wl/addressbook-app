//
//  Unicode.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/26.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

enum UnicodeUtility {
    
    static let HANGUL_CONSONANTS = Array(0x1100...0x1112)
    static let HANGUL_DOUBLE_CONSONANTS = [0x1101, 0x1104, 0x1108, 0x110A, 0x110D]
    
    static let ALPHABET = Array(0x0041...0x5A)
    
    static let UNICODE_DICTIONARY = (HANGUL_CONSONANTS + ALPHABET)
        .filter { !HANGUL_DOUBLE_CONSONANTS.contains($0) }
        .compactMap { UnicodeScalar($0) }
        .map { "\(Character($0))" }
        .reduce(into: [String: [Address]]()) { $0[$1] = [Address]() }
}
