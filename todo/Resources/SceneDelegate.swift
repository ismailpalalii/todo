//
//  SceneDelegate.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let loginViewController = ServiceLocator.makeTaskListViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
      }
      
      func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataStack.shared.saveContext()
      }
}

