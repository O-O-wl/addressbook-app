//
//  Contact.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//
import Contacts
import Foundation

enum ContactKey: CaseIterable {
    
    case imageData
    case givenName
    case familyName
    case emailAddresses
    case phoneNumbers
    
    var descriptor: CNKeyDescriptor {
        var keyString = ""
        switch self {
        case .imageData:
            keyString = CNContactImageDataKey
        case .givenName:
            keyString = CNContactGivenNameKey
        case .familyName:
            keyString = CNContactFamilyNameKey
        case .emailAddresses:
            keyString = CNContactEmailAddressesKey
        case .phoneNumbers:
            keyString = CNContactPhoneNumbersKey
        }
        return keyString as CNKeyDescriptor
    }
}

