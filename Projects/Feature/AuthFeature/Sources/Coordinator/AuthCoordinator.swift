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
  func goToDone()
  
  func goBack()
}

public class AuthCoordinator: Coordinator {
  public var parentCoordinator: Coordinator?
  public var childCoordinators = [Coordinator]()
  
  private let navigationController: UINavigationController
  
  private let viewModel: AuthViewModel = AuthViewModel()
  
  public init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let authMainVC = AuthMainVC()
    authMainVC.viewModel = viewModel
    
    viewModel.delegate = self
    navigationController.pushViewController(authMainVC, animated: false)
  }
}

extension AuthCoordinator: AuthViewModelDelegate {
  
  public func goToNickname() {
    let setNicknameVC = SetNicknameVC()
    setNicknameVC.viewModel = viewModel
    
    navigationController.pushViewController(setNicknameVC, animated: true)
  }
  
  public func goToDone() {
    let signUpDoneVC = SignUpDoneVC()
    signUpDoneVC.viewModel = viewModel
    
    navigationController.pushViewController(signUpDoneVC, animated: true)
  }
  
  public func goBack() {
    navigationController.popViewController(animated: true)
  }
}
