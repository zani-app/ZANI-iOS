//
//  NightCoordinator.swift
//  NightMainFeatureInterface
//
//  Created by 정도현 on 11/25/24.
//  Copyright © 2024 zani.com. All rights reserved.
//

import UIKit

import NightMainFeatureInterface

import BaseFeature

public class NightCoordinator: Coordinator {
  public var parentCoordinator: Coordinator?
  public var childCoordinators = [Coordinator]()
  
  private let navigationController: UINavigationController
  
  private let viewModel: NightViewModel = NightViewModel()
  
  public init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let nightMainVC = NightMainVC()
    nightMainVC.viewModel = viewModel
    
    navigationController.pushViewController(nightMainVC, animated: false)
  }
}
