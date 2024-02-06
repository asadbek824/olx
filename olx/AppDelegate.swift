//
//  AppDelegate.swift
//  olx
//
//  Created by Asadbek on 19/12/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
var window: UIWindow?
    
    private let profileVC = UINavigationController(rootViewController: ViewController())
    private let messageVC = UINavigationController(rootViewController: MessageViewController())
    private let createVC = UINavigationController(rootViewController: CreateViewController())
    private let sortedVC = UINavigationController(rootViewController: SortedViewController())
    private let mainVC = UINavigationController(rootViewController: MainViewController2())

    func application(
        _ application: UIApplication, 
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        profile()
        message()
        create()
        sorted()
        main()
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [mainVC, sortedVC, createVC, messageVC, profileVC]
        tabBarVC.selectedIndex = 0
        tabBarVC.tabBar.backgroundColor = .white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

extension  AppDelegate {
    
    func profile() {
        
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
    }
    
    func message() {
        
        messageVC.tabBarItem.title = "Сообщения"
        messageVC.tabBarItem.image = UIImage(systemName: "message")
    }
    
    func create() {
        
        createVC.tabBarItem.title = "Создать"
        createVC.tabBarItem.image = UIImage(systemName: "plus.circle")
    }
    
    func sorted() {
        
        sortedVC.tabBarItem.title = "Избранное"
        sortedVC.tabBarItem.image = UIImage(systemName: "star")
    }
    
    func main() {
        
        mainVC.tabBarItem.title = "Главная"
        mainVC.tabBarItem.image = UIImage(systemName: "house")
    }
}

