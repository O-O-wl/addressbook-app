//
//  AddressBookViewController.swift
//  
//
//  Created by 이동영 on 2019/11/21.
//

import UIKit
import SnapKit
import Then

//MARK: - AddressBookPresentable
protocol AddressBookPresentable: AnyObject {
    
    var viewModel: AddressBookViewBindable? { get set }
}

// MARK: - AddressBookViewController
class AddressBookViewController: UITableViewController, AddressBookPresentable {
    
    // MARK: - UI
    
    private let searchbar = UISearchBar()
    private let cancelButton = UIButton()
    
    // MARK: - Dependencies
    
    var viewModel: AddressBookViewBindable? {
        didSet { bindViewModel() }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttribute()
        setUpConstraints()
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
        
        viewModel.dataDidUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.errorDidOccured = { [weak self] error in
            let alertVC =  UIAlertController(title: "에러 발생",
                                             message: error.localizedDescription,
                                             preferredStyle: .alert)
            self?.present(alertVC, animated: true, completion: nil) }
    }
}
// MARK: - Layout & Attributes
extension AddressBookViewController {
    
    private func setUpAttribute() {
        self.navigationController?.navigationBar.do {
            $0.addSubview(searchbar)
            $0.addSubview(cancelButton)
        }
        
        self.tableView.do {
            $0.rowHeight = 90
            $0.register(AddressCell.self,
                        forCellReuseIdentifier: AddressCell.reuseIdentifier)
        }
        
        searchbar.do {
            $0.keyboardType = .emailAddress
            $0.delegate = self
        }
        
        cancelButton.do {
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.setTitle("Cancel", for: .normal)
        }
    }
    
    private func setUpConstraints() {
        searchbar.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-10)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
        
        cancelButton.snp.contentCompressionResistanceHorizontalPriority = 1000
    }
}
// MARK: - UITableViewDataSource
extension AddressBookViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numOfBundles ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?[section: section]?.list.count ?? 0
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard let count = viewModel?.numOfBundles else { return [] }
        
        return (0..<count).compactMap { viewModel?[section: $0]?.initiality }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withType: AddressCell.self, for: indexPath),
            let address = viewModel?[row: indexPath]
            else { return AddressCell() }
        
        cell.configure(address)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.tableView(tableView, numberOfRowsInSection: section) <= 0 {
            return 0
        }
        return 35
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView().then { $0.backgroundColor = .systemGray5 }
        let label = UILabel().then { $0.text = viewModel?[section: section]?.initiality }
        header.addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        return header
    }
}
// MARK: - UISearchBarDelegate
extension AddressBookViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel?.typedText = searchText
    }
}
