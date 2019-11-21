//
//  AddressCell.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/22.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import SnapKit
import Then

class AddressCell: UITableViewCell {
    
    // MARK: - UI
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let telLabel = UILabel()
    private let emailLabel = UILabel()
    
    // MARK: - Configure
    func configure(_ address: Address) {
        setUpAttribute()
        setUpConstraint()
        var profileImage: UIImage?
        if let imageData = address.imageData {
           profileImage = UIImage(data: imageData)
        }
        profileImageView.image = profileImage ?? #imageLiteral(resourceName:"addressbook-default-profile")
        nameLabel.text = address.name
        telLabel.text = address.tel
        emailLabel.text = address.email
    }
}
// MARK: - Layout & Attributes
extension AddressCell {
    
    private func setUpAttribute() {
        
        profileImageView.do {
            self.contentView.addSubview($0)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        
        nameLabel.do {
            self.contentView.addSubview($0)
            $0.textAlignment = .left
            $0.font.withSize(24)
            $0.textColor = .black
        }
        
        telLabel.do {
            self.contentView.addSubview($0)
            $0.textAlignment = .right
            $0.font.withSize(17)
            $0.textColor = .lightGray
        }
        
        emailLabel.do {
            self.contentView.addSubview($0)
            $0.textAlignment = .left
            $0.font.withSize(16)
            $0.textColor = .darkGray
        }
    }
    
    private func setUpConstraint() {
        profileImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(30)
            make.top.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(2).dividedBy(3)
        }
        
        telLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.height.equalToSuperview().multipliedBy(1).dividedBy(3)
        }
    }
}
