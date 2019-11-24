//
//  AppDelegate.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/21.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let addressViewModel = AddressBookViewModel(service: ContactService.shared)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.openSessions.first?.userInfo?["ViewModel"] = addressViewModel
        return true
    }
}

