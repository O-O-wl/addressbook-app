//
//  AddressBookViewModel.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

// MARK: - AddressBookViewBindable
protocol AddressBookViewBindable: AnyObject {
    
    
    var dataDidLoad: (() -> Void)? { get set }
    var errorDidOccured: ((Error) -> Void)? { get set }
    var count: Int { get }
    
    subscript(at indexPath: IndexPath) -> Address? { get }
}

// MARK: - AddressBookViewModel
class AddressBookViewModel: AddressBookViewBindable {
    
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
    
    var errorDidOccured: ((Error) -> Void)?
    
    // MARK: - Initializer
    init(service: ContactService) {
        self.service = service
    }
    
    // MARK: - Methods
    var count: Int {
        return addresses?.count ?? 0
    }
    
    subscript(at indexPath: IndexPath) -> Address? {
        guard count > indexPath.row else { return nil }
        
        return addresses?[indexPath.row]
    }
    
    private func fetchRequest() {
        service.fetchContacts { [weak self] result in
            switch(result) {
            case .success(let contacts):
                self?.addresses = contacts.map {
                    Address(imageData: $0.imageData,
                            name: $0.givenName + $0.familyName,
                            tel: $0.phoneNumbers.first?.value.stringValue ?? "",
                            email: $0.emailAddresses.first?.value as String? ?? "" )
                }
            case .failure(let error):
                self?.errorDidOccured?(error)
            }
        }
    }
}
