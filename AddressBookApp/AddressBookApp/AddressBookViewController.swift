//
//  AddressBookViewController.swift
//  
//
//  Created by 이동영 on 2019/11/21.
//

import UIKit
import SnapKit
import Then

protocol AddressBookPresentable: AnyObject {
    
    var viewModel: AddressBookViewBindable? { get set }
}

class AddressBookViewController: UITableViewController, AddressBookPresentable {
    
    
    // MARK: - Dependencies
    var viewModel: AddressBookViewBindable? {
        didSet { bindViewModel() }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
}
// MARK: - Bind
extension AddressBookViewController {
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.dataDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.errorDidOccured = { [weak self] error in
            UIAlertController(title: "에러 발생",
                              message: error.localizedDescription,
                              preferredStyle: .alert).then { self?.present($0, animated: true, completion: nil)}
        }
    }
}
// MARK: - Layout & Attributes
extension AddressBookViewController {
    
    private func setUpTableView() {
        self.tableView.do {
            $0.rowHeight = 90
            $0.register(AddressCell.self, forCellReuseIdentifier: AddressCell.reuseIdentifier)
        }
    }
}
// MARK: - UITableViewDataSource
extension AddressBookViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numOfAddress ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withType: AddressCell.self, for: indexPath),
            let address = viewModel?.getAddress(at: indexPath.row)
            else { return AddressCell() }
        
        cell.configure(address)
        return cell
    }
}
