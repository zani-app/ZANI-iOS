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
  
  public var childCoordinators: [Coordinator] = []
  
  private let navigationController: UINavigationController
  private var isLoggedIn: Bool
  
  public init(navigationController: UINavigationController, isLoggedIn: Bool) {
    self.navigationController = navigationController
    self.isLoggedIn = isLoggedIn
  }
  
  public func start() {
    runAuthFlow()
  }
  
  private func runAuthFlow() {
    let authCoordinator = AuthCoordinator(navigationController: navigationController)
    childCoordinators.append(authCoordinator)
    authCoordinator.start()
  }
}
