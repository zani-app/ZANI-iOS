//
//  AppCoordinator.swift
//  RootFeature
//
//  Created by 정도현 on 11/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

import AuthFeature
import BaseFeature

public class AppCoordinator: Coordinator {
  
  public var parentCoordinator: Coordinator? = nil
  public var childCoordinators: [Coordinator] = []
  
  private let window: UIWindow?
  
  lazy var navigationController: UINavigationController = {
    let rootViewController = UIViewController()
    let navigationController = UINavigationController(rootViewController: rootViewController)
    return navigationController
  }()
  
  public init(window: UIWindow?) {
    self.window = window
  }
  
  public func start() {
    guard let window = window else { return }
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    runAuthFlow()
  }
}

extension AppCoordinator {
  private func runAuthFlow() {
    let authCoordinator = AuthCoordinator(navigationController: navigationController)
    authCoordinator.parentCoordinator = self
    addChildCoordinator(authCoordinator)
    authCoordinator.start()
  }
}
