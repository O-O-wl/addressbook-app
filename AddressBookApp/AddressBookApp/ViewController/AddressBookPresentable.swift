//
//  AddressBookPresentable.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/27.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

//MARK: - AddressBookPresentable
protocol AddressBookPresentable: AnyObject {
    
    var viewModel: AddressBookViewBindable? { get set }
}
