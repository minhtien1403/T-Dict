//
//  SceneDelegate.swift
//  T-Dict
//
//  Created by Tiến on 3/16/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        createTabbar()
    }
    
    func createTabbar(){
        let searchVC = SearchViewController()

        let searchNavi = BaseNavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = TabbarItem.search.item
        
        let listVC = ListViewController()
        listVC.tabBarItem = TabbarItem.list.item
        let listNavi = BaseNavigationController(rootViewController: listVC)
        
        let utilitiesVC = UtilitiesViewController()
        utilitiesVC.tabBarItem = TabbarItem.utilities.item
        let utilitiesNavi = BaseNavigationController(rootViewController: utilitiesVC)
        
        //tabbar
        let tabbarController = UITabBarController()
        tabbarController.tabBar.isTranslucent = false
        tabbarController.tabBar.backgroundColor = .white
        tabbarController.tabBar.tintColor = .black
        tabbarController.viewControllers = [searchNavi, listNavi, utilitiesNavi]
    
        window?.rootViewController = tabbarController
    }
}
