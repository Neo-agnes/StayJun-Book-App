//
//  SceneDelegate.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/3/24.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = ViewController()
//        window?.makeKeyAndVisible()
        
        // 탭 바 컨트롤러 생성
        let tabBarController = UITabBarController()
        
        
        // 각 탭에 해당하는 뷰 컨트롤러 생성
        let searchViewController = SearchViewController() // 책 검색 화면
        let savedBooksViewController = SavedBooksViewController() // 담은 책 리스트 화면
        
        // 뷰 컨트롤러들을 탭 바 컨트롤러에 추가
        tabBarController.viewControllers = [searchViewController, savedBooksViewController]
        
        // 윈도우 생성 및 루트 뷰 컨트롤러로 탭 바 컨트롤러 설정
        tabBarController.tabBarItem.image
//        window = UIWindow(frame: UIScreen.main.bounds)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        // 탭 바 컨트롤러 생성
//        let tabBarController = UITabBarController()
//
//        // 첫 번째 탭: 책 검색 화면
//        let searchViewController = SearchViewController()
//        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//
//        // 두 번째 탭: 담은 책 리스트 화면
//        let savedBooksViewController = SavedBooksViewController()
//        savedBooksViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//
//        // 탭 바 컨트롤러에 뷰 컨트롤러들 추가
//        tabBarController.viewControllers = [searchViewController, savedBooksViewController]
//
//        // 윈도우 생성 및 루트 뷰 컨트롤러 설정
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = tabBarController // 탭 바 컨트롤러를 루트로 설정
//        self.window = window
//        window.makeKeyAndVisible()
//    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

