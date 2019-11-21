//
//  Reuseable.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

protocol Reuseable {
    
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reuseable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
