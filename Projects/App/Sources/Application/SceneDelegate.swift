
import UIKit

import RootFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: scene.coordinateSpace.bounds)
    window?.windowScene = scene
    
    let isLoggedIn = false // Test
    let navigationController = UINavigationController()
    
    self.window?.rootViewController = navigationController
    let coordinator = AppCoordinator(navigationController: navigationController, isLoggedIn: isLoggedIn)
    coordinator.start()
    
    window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  
  func sceneDidBecomeActive(_ scene: UIScene) {}
  
  func sceneWillResignActive(_ scene: UIScene) {}
  
  func sceneWillEnterForeground(_ scene: UIScene) {}
  
  func sceneDidEnterBackground(_ scene: UIScene) {}
}
