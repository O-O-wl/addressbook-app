//
//  AddressBookViewModel.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//
import Contacts
import Foundation

typealias ContactsBundle = (initiality: String, list: [Address])

// MARK: - AddressBookViewBindable
protocol AddressBookViewBindable: AnyObject {
    
    
    var dataDidLoad: (() -> Void)? { get set }
    var errorDidOccured: ((Error) -> Void)? { get set }
    var numOfBundles: Int { get }
    
    subscript(section index: Int) -> ContactsBundle? { get }
    subscript(row indexPath: IndexPath) -> Address? { get }
}

// MARK: - AddressBookViewModel
class AddressBookViewModel: AddressBookViewBindable {
    
    // MARK: - Dependencies
    
    private let service: ContactService
    
    // MARK: - Properties
    
    private var addresses: [Address]? {
        didSet { dataDidLoad?() }
    }
    var typedText: String = "" {
        didSet { dataDidUpdate?() }
    }
    
    private var contacts: [ContactsBundle]? {
        get {
            addresses?
                .filter(filter)
                .reduce(into: UnicodeUtility.UNICODE_DICTIONARY) { classify(to: &$0, with: $1) }
                .map { (initality: $0.key, list: $0.value) }
                .sorted { $0.initiality < $1.initiality }
        }
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
    
    var numOfBundles: Int {
        return contacts?.count ?? 0
    }
    
    subscript(section index: Int) -> ContactsBundle? {
        return contacts?[index]
    }
    
    subscript(row indexPath: IndexPath) -> Address? {
        return contacts?[indexPath.section].list[indexPath.row]
    }
    
    private func fetchRequest() {
        service.fetchContacts { [weak self] result in
            switch(result) {
            case .success(let contacts):
                self?.addresses = contacts
                    .compactMap { self?.parse(cotact: $0) }
                    .reduce(into: UnicodeUtility.UNICODE_DICTIONARY) { total, new in self?.classify(to: &total, with: new) }
                    .map { (initality: $0.key, list: $0.value) }
                    .sorted { $0.initiality < $1.initiality }
            case .failure(let error):
                self?.errorDidOccured?(error)
            }
        }
    }
    
    private func parse(cotact: CNContact) -> Address {
        return  Address(imageData: cotact.imageData,
                        name: cotact.familyName + cotact.givenName,
                        tel: cotact.phoneNumbers.first?.value.stringValue ?? "",
                        email: cotact.emailAddresses.first?.value as String? ?? "" )
    }
    
    private func classify(to dictionary: inout [String: [Address]], with address: Address) {
        if let firstSpell = address.name.firstSpell {
            dictionary[firstSpell, default: [Address]()].append(address)
        }
    }
}
