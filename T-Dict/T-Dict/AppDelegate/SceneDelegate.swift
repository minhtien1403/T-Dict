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
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(title: "Search",
                                           image: UIImage(named: "ic-search"),
                                           selectedImage: nil)
        searchNavi.navigationBar.barTintColor = UIColor(rgb: 0xFE2200)
        searchNavi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                        NSAttributedString.Key.font: UIFont(name: "BreeSerif-Regular", size: 24) ?? UIFont.boldSystemFont(ofSize: 24.0)]
        
        let listVC = ListViewController()
        let listNavi = UINavigationController(rootViewController: listVC)
        listVC.tabBarItem = UITabBarItem(title: "List",
                                         image: UIImage(named: "ic-list"),
                                         selectedImage: nil)
        listNavi.navigationBar.barTintColor = UIColor(rgb: 0xFE2200)
        listNavi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                      NSAttributedString.Key.font: UIFont(name: "BreeSerif-Regular", size: 24) ?? UIFont.boldSystemFont(ofSize: 24.0)]
        
        let utilitiesVC = UtilitiesViewController()
        let utilitiesNavi = UINavigationController(rootViewController: utilitiesVC)
        utilitiesVC.tabBarItem = UITabBarItem(title: "Utilities",
                                              image: UIImage(named: "ic-utilities"),
                                              selectedImage: nil)
        utilitiesNavi.navigationBar.barTintColor = UIColor(rgb: 0xFE2200)
        utilitiesNavi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                           NSAttributedString.Key.font: UIFont(name: "BreeSerif-Regular", size: 24) ?? UIFont.boldSystemFont(ofSize: 24.0)]
        
        //tabbar
        let tabbarController = UITabBarController()
        tabbarController.tabBar.isTranslucent = false
        tabbarController.tabBar.backgroundColor = .white
        tabbarController.tabBar.tintColor = .black
        tabbarController.viewControllers = [searchNavi, listNavi, utilitiesNavi]
    
        window?.rootViewController = tabbarController
    }

}
