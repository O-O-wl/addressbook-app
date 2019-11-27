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
    
    var typedText: String { get set }
    var numOfBundles: Int { get }
    
    var dataDidLoad: (() -> Void)? { get set }
    var errorDidOccured: ((Error) -> Void)? { get set }
    var dataDidUpdated: (() -> Void)? { get set }
    
    subscript(section index: Int) -> ContactsBundle? { get }
    subscript(row indexPath: IndexPath) -> Address? { get }
}

// MARK: - AddressBookViewModel
class AddressBookViewModel: AddressBookViewBindable {
    
    // MARK: - Dependencies
    
    private let service: ContactService
    
    // MARK: - Store Properties
    
    private var addresses: [Address]? {
        didSet { dataDidLoad?() }
    }
    
    var typedText: String = "" {
        didSet { dataDidUpdated?() }
    }
    
    // MARK: - Computed Properties
    
    private var contacts: [ContactsBundle]? {
        get {
            addresses?
                .filter(filter)
                .reduce(into: UnicodeUtility.UNICODE_DICTIONARY) { classify(to: &$0, with: $1) }
                .map { (initality: $0.key, list: $0.value) }
                .sorted { $0.initiality < $1.initiality }
        }
    }
    
    var numOfBundles: Int {
        return contacts?.count ?? 0
    }
    // MARK: - Status Closure
    
    var dataDidLoad: (() -> Void)? {
        didSet { fetchRequest() }
    }
    
    var errorDidOccured: ((Error) -> Void)?
    
    var dataDidUpdated: (() -> Void)?
    
    // MARK: - Initializer
    
    init(service: ContactService) {
        self.service = service
    }
    
    // MARK: - Subscript
    
    subscript(section index: Int) -> ContactsBundle? {
        return contacts?[index]
    }
    
    subscript(row indexPath: IndexPath) -> Address? {
        return contacts?[indexPath.section].list[indexPath.row]
    }
    
    // MARK: - Methods
    
    private func fetchRequest() {
        service.fetchContacts { [weak self] result in
            switch(result) {
            case .success(let contacts):
                self?.addresses = contacts
                    .compactMap { self?.parse(contact: $0) }
            case .failure(let error):
                self?.errorDidOccured?(error)
            }
        }
    }
    
    private func parse(contact: CNContact) -> Address {
        return  Address(imageData: contact.imageData,
                        name: contact.familyName + contact.givenName,
                        tel: contact.phoneNumbers.first?.value.stringValue ?? "",
                        email: contact.emailAddresses.first?.value as String? ?? "" )
    }
    
    private func filter(address: Address) -> Bool {
        let name = address.name.lowercased()
        let searchedText = typedText.lowercased()
        
        if !searchedText.isCompletion {
            let nameInitiality = name.chacters.compactMap { $0.initiality }
            let searchedInitiality = searchedText.chacters.compactMap { $0.initiality }
            return nameInitiality.hasPrefix(searchedInitiality)
        }
        return name.hasPrefix(searchedText)
    }
    
    private func classify(to dictionary: inout [String: [Address]], with address: Address) {
        if let firstSpell = address.name.firstSpell {
            dictionary[firstSpell, default: [Address]()].append(address)
        }
    }
    
}
