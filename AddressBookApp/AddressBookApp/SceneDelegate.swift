//
//  SceneDelegate.swift
//  AddressBookApp
//
//  Created by 이동영 on 2019/11/21.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let addressViewModel = session.userInfo?["ViewModel"] as? AddressBookViewBindable
        let addressViewController = AddressBookViewController().then { $0.viewModel = addressViewModel }
        
        self.window = UIWindow(windowScene: scene).then {
                $0.rootViewController = UINavigationController(rootViewController: addressViewController)
                $0.makeKeyAndVisible()
        }
        
    }
    
}

