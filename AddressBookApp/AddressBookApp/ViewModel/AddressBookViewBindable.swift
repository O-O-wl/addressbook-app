//
//  AddressBookBindable.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/27.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

// MARK: - AddressBookViewBindable
protocol AddressBookViewBindable: AnyObject, TextHandlable {
    
    var numOfBundles: Int { get }
    
    var dataDidLoad: (() -> Void)? { get set }
    var errorDidOccured: ((Error) -> Void)? { get set }
    var dataDidUpdated: (() -> Void)? { get set }
    
    subscript(section index: Int) -> ContactsBundle? { get }
    subscript(row indexPath: IndexPath) -> Address? { get }
}

protocol TextHandlable {
    
    var text: String { get set }
}
