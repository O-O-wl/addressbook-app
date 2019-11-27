//
//  ContactServable.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/27.
//  Copyright © 2019 이동영. All rights reserved.
//
import Contacts
import Foundation

protocol ContactServable {
    
   func fetchContacts(_ completion: @escaping (Result<[CNContact], Error>) -> Void)
}
