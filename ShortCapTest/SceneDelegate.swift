//
//  SceneDelegate.swift
//  ShortCapTest
//
//  Created by 최준영 on 3/3/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let dataFetcher = ShortCapContainer()
        
        let apiService = DefaultSummaryService()

        let scListViewModel = SummaryContentListViewModel(sfFetcher: dataFetcher, apiService: apiService)
        
        let scListVC = SummaryContentListViewController(summaryListViewModel: scListViewModel)
        let navigationVC = UINavigationController(rootViewController: scListVC)

        window?.rootViewController = navigationVC
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
        
        
        if let navigationController = window?.rootViewController as? UINavigationController {
            
            if let scListVc = navigationController.viewControllers.first(where: { vc in
                type(of: vc) == SummaryContentListViewController.self
            }) as? SummaryContentListViewController {
                
                // 파일시스템 데이터를 코어데이터로
                scListVc.summaryListViewModel.moveFileDataToCoreData()
                
                // 코어 데이터에서 데이터 다시 가져오기
                scListVc.summaryListViewModel.fetchLocalDataFromCoreData()
                
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

