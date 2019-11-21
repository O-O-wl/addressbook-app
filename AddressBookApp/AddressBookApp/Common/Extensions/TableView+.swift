//
//  TableView+.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<Cell: Reuseable>(withType cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
    }
}
