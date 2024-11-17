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

public protocol AuthViewModelDelegate: AnyObject {
  func goToNickname()
  func goBack()
}

public class AuthCoordinator: Coordinator {
  public var parentCoordinator: Coordinator?
  public var childCoordinators = [Coordinator]()
  
  private let navigationController: UINavigationController
  
  private let viewModel: AuthViewModel = AuthViewModel()
  
  private let authMainVC = AuthMainVC()
  private let setNicknameVC = SetNicknameVC()
  
  public init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }
  
  public func start() {
    viewModel.delegate = self
    authMainVC.viewModel = viewModel
    navigationController.pushViewController(authMainVC, animated: false)
  }
}

extension AuthCoordinator: AuthViewModelDelegate {
  public func goToNickname() {
    setNicknameVC.viewModel = viewModel
    navigationController.pushViewController(setNicknameVC, animated: true)
  }
  
  public func goBack() {
    navigationController.popViewController(animated: true)
  }
}
