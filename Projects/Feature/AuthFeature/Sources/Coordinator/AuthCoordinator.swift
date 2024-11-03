//
//  AuthCoordinator.swift
//  AuthFeatureInterface
//
//  Created by 정도현 on 11/3/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

import AuthFeatureInterface

import BaseFeature

public final class AuthCoordinator: Coordinator {
  public var childCoordinators: [Coordinator] = []
  
  private let navigationController: UINavigationController
  
  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let authVC = SetNicknameVC()
    navigationController.pushViewController(authVC, animated: true)
  }
}
