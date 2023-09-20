//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Seher Köse on 5.09.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

// guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        window?.windowScene = windowScene
//        window?.rootViewController = createOnBoardingController() //LoginVC()  //RegisterVC() //LoginVC()
//        // LoginVC() //createTabbar()
//        window?.makeKeyAndVisible()
        
        self.setUpWindow(with: scene)
        self.checkAuthentication()
        configureNavigationBar()
    }
    
    private func setUpWindow(with scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication(){
        if Auth.auth().currentUser == nil{
            //go to sign in
//            let vc = createOnBoardingController()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .fullScreen
//            self.window?.rootViewController = nav
            self.goToController(with: OnboardingVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil))
            
        } else{
            //go to home
//            let vc = createTabbar()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .fullScreen
//            self.window?.rootViewController = nav
            self.goToController(with: createTabbar())
        }
    }
    
    private func goToController(with viewController: UIViewController){
        DispatchQueue.main.async {[weak self] in
            UIView.animate(withDuration: 0.25){
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
//    func createOnBoardingController() -> UINavigationController{
//        let onboardingVC = OnboardingVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        onboardingVC.title = ""
//        return UINavigationController(rootViewController: onboardingVC)
//    }
    
    func createSearchNavigationController() -> UINavigationController{
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }

    func createFavoritesListNavigationController() -> UINavigationController{
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
    func createProfileInfoNavigationController() -> UINavigationController{
        let profileInfoVC = ProfileInfoVC()
        profileInfoVC.title = " "
        profileInfoVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        return UINavigationController(rootViewController: profileInfoVC)
    }
    
    func createTabbar() -> UITabBarController{
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = UIColor(hex: "235B8C")
        UITabBar.appearance().unselectedItemTintColor = .gray
        tabbar.viewControllers = [createSearchNavigationController(), createFavoritesListNavigationController(), createProfileInfoNavigationController()]
        
        UITabBar.appearance().backgroundColor = UIColor(hex: "F8F0E5")
        
        return tabbar
    }
    
    func switchToTabBarController() {
        let tabBarController = createTabbar()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
       
    }
    
    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = UIColor(hex: "235B8C")
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
    }


}

