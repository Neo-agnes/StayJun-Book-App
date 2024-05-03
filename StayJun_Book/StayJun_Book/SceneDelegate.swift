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
        
        // MARK: - 컨트롤러들의 장면 컨트롤
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 탭 바 컨트롤러 생성
        let tabBarController = UITabBarController()
        
        // 각 탭에 해당하는 뷰 컨트롤러 생성
        let searchViewController = SearchViewController() // 책 검색 화면
        // 책 검색 아이콘 설정
        let searchTabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        
        searchViewController.tabBarItem = searchTabBarItem
        
        let savedBooksViewController = SavedBooksViewController() // 담은 책 리스트 화면
        
        // 책 리스트 아이콘 설정
        let savedBooksTabBarItem = UITabBarItem(title: "Saved Books", image: UIImage(systemName: "book"), selectedImage: nil)
        
        savedBooksViewController.tabBarItem = savedBooksTabBarItem
        
        // 뷰 컨트롤러들을 탭 바 컨트롤러에 추가
        tabBarController.viewControllers = [searchViewController, savedBooksViewController]
        
        // 윈도우 생성 및 루트 뷰 컨트롤러로 탭 바 컨트롤러 설정
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    

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

