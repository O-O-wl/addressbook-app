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
        profileImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(profileImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(2).dividedBy(3)
        }
        
        telLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.height.equalToSuperview().multipliedBy(1).dividedBy(3)
        }
    }
}
