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

// MARK: - AddressBookViewModel
class AddressBookViewModel: AddressBookViewBindable {
    
    // MARK: - Dependencies
    
    private let service: ContactServable
    
    // MARK: - Stored Properties
    
    private var addresses: [Address]? {
        didSet { dataDidLoad?() }
    }
    
    var text: String = "" {
        didSet { dataDidUpdated?() }
    }
    
    // MARK: - Computed Properties
    
    private var contacts: [ContactsBundle]? {
        get {
            addresses?
                .filter(check)
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
    
    init(service: ContactServable) {
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
                    .compactMap { self?.make(from: $0) }
            case .failure(let error):
                self?.errorDidOccured?(error)
            }
        }
    }
    
    private func make(from contact: CNContact) -> Address {
        return  Address(imageData: contact.imageData,
                        name: contact.familyName + contact.givenName,
                        tel: contact.phoneNumbers.first?.value.stringValue ?? "",
                        email: contact.emailAddresses.first?.value as String? ?? "" )
    }
    
    private func check(address: Address) -> Bool {
        let name = address.name.lowercased()
        let searchedText = text.lowercased()
        
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
