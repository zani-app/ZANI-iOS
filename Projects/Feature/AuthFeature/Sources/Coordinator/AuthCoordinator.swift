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
  func finish()
  
  func goBack()
}

public class AuthCoordinator: Coordinator {
  public var parentCoordinator: Coordinator?
  public var childCoordinators = [Coordinator]()
  
  private let navigationController: UINavigationController
  
  private let mainVM: AuthMainViewModel = AuthMainViewModel()
  private let nicknameVM: AuthNicknameViewModel = AuthNicknameViewModel()
  
  public init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let authMainVC = AuthMainVC()
    authMainVC.viewModel = mainVM
    
    mainVM.delegate = self
    navigationController.pushViewController(authMainVC, animated: false)
  }
}

extension AuthCoordinator: AuthViewModelDelegate {
  
  public func goToNickname() {
    let setNicknameVC = SetNicknameVC()
    setNicknameVC.viewModel = nicknameVM
    
    nicknameVM.delegate = self
    navigationController.pushViewController(setNicknameVC, animated: true)
  }
  
  public func goToDone() {
    let signUpDoneVC = SignUpDoneVC()
    // signUpDoneVC.viewModel = viewModel
    
    navigationController.pushViewController(signUpDoneVC, animated: true)
  }
  
  public func goBack() {
    navigationController.popViewController(animated: true)
  }
}
