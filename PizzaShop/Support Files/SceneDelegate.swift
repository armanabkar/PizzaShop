//
//  SceneDelegate.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Task.init {
            try? await WebService.shared.start()
        }
        if !UserDefaultsService.shared.name.isEmpty &&
            !UserDefaultsService.shared.phone.isEmpty &&
            !UserDefaultsService.shared.address.isEmpty {
            let board = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = board.instantiateViewController(identifier: "tabBar") as! UITabBarController
            window?.rootViewController = tabBar
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
}

