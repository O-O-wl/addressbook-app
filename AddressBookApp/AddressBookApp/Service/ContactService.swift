//
//  ContactService.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import Contacts
import Foundation


class ContactService {
   
    // MARK: - Singletone
    
    static let shared = ContactService()
    
    // MARK: - Properties
    
    private let store = CNContactStore()
    private let contactAccessQueue = DispatchQueue(label: "ContactAccessQueue",
                                                   attributes: DispatchQueue.Attributes.concurrent)
    // MARK: - Initializdr
    
    private init() {}
    
    // MARK: - Methods
    
    func fetchContacts(_ completion: @escaping (Result<[CNContact], Error>) -> Void) {
        var result = [CNContact]()
        let keysToFetch = ContactKey.allCases.map { $0.descriptor }
        let request = CNContactFetchRequest(keysToFetch: keysToFetch).then { $0.sortOrder = .familyName }
        
        contactAccessQueue.async {
            do {
                try self.store.enumerateContacts(with: request) { contact, _ in
                    result.append(contact)
                    completion(.success(result))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
