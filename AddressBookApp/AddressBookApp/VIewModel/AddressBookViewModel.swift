//
//  AddressBookViewModel.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

// MARK: - AddressBookViewModelType
protocol AddressBookViewModelType: AnyObject {
    
    var numOfAddress: Int { get }
    var dataDidLoad: (() -> Void)? { get set }
    
    func getAddress(at index: Int) -> Address?
}

// MARK: - AddressBookViewModel
class AddressBookViewModel: AddressBookViewModelType {
    
    // MARK: - Dependencies
    private let service: ContactService
    
    // MARK: - Properties
    private var addresses: [Address]? {
        didSet { dataDidLoad?() }
    }
    
    // MARK: - Status Closure
    var dataDidLoad: (() -> Void)? {
        didSet { fetchRequest() }
    }
    
    // MARK: - Initializer
    init(service: ContactService) {
        self.service = service
    }
    
    // MARK: - Methods
    var numOfAddress: Int {
        return addresses?.count ?? 0
    }
    
    func getAddress(at index: Int) -> Address? {
        guard
            let addresses = addresses,
            addresses.count > index
            else { return nil }
        
        return addresses[index]
    }
    
    private func fetchRequest() {
        service.fetchContacts { [weak self] contacts in
            self?.addresses = contacts.map {
                Address(imageData: $0.imageData,
                        name: $0.givenName + $0.familyName,
                        tel: $0.phoneNumbers.first?.value.stringValue ?? "",
                        email: $0.emailAddresses.first?.value as String? ?? "" )
            }
        }
    }
}